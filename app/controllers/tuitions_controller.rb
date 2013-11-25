class TuitionsController < ApplicationController

  before_action :set_tuition, only: [:show, :edit, :update, :destroy, :fix]

  # GET /tuitions
  # GET /tuitions.json
  def index
    redirect_to tuitions_path payment_method: "DEBIT" if params[:payment_method].nil?
    if params[:payment_method] == "DEBIT"
      debits
    elsif params[:payment_method] == "CASH"
      receipts
    end
  end

  def debits
    @tuitions = Tuition.all.decorate
    respond_to do |format|
      format.html { render action: "debits" }
    end
  end

  def receipts
    statuses = [Tuition::RECEIPT_STATUSES[:IN_PROCESS], Tuition::RECEIPT_STATUSES[:FINISHED]]
    @tuitions = Tuition.where(receipt_status: statuses).decorate
    respond_to do |format|
      format.html { render action: "receipts" }
    end
  end

  # GET /tuitions/1
  # GET /tuitions/1.json
  def show
  end

  # GET /tuitions/new
  def new
    @tuition = Tuition.new(debit_status: Tuition::DEBIT_STATUSES[:IN_PROCESS],
                           receipt_status: Tuition::RECEIPT_STATUSES[:NONE])
  end

  # GET /tuitions/1/edit
  def edit
  end

  # POST /tuitions
  # POST /tuitions.json
  def create
    ActiveRecord::Base.transaction do
      tuition = Tuition.new month: params[:month],
                            debit_status: Tuition::DEBIT_STATUSES[:IN_PROCESS],
                            receipt_status: Tuition::RECEIPT_STATUSES[:NONE]
      tuition.save!
      TuitionsService.new(tuition).begin
    end
    respond_to do |format|
      format.html { redirect_to tuitions_url }
    end
  rescue => e
    flash[:error] = "登録に失敗しました。" + e.to_s
    redirect_to action: "index"
  end

  def fix
    ActiveRecord::Base.transaction do
      TuitionsService.new(@tuition).end
    end
    respond_to do |format|
      format.html { redirect_to tuition_debits_path(@tuition) }
    end
  rescue => e
    flash[:error] = "確定に失敗しました。" + e.to_s
    redirect_to tuition_debits_path(@tution)
  end

  # PATCH/PUT /tuitions/1
  # PATCH/PUT /tuitions/1.json
  def update
    respond_to do |format|
      if @tuition.update(tuition_params)
        #format.html { redirect_to @tuition, notice: 'Tuition was successfully updated.' }
        format.html { redirect_to tuitions_url, notice: "月謝の引落を終了しました。" }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @tuition.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tuitions/1
  # DELETE /tuitions/1.json
  def destroy
    @tuition.destroy
    respond_to do |format|
      format.html { redirect_to tuitions_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tuition
      @tuition = Tuition.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tuition_params
      params.require(:tuition).permit(:month, :debit_status, :receipt_status, :note)
    end
end

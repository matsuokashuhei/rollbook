class TuitionsController < ApplicationController

  before_action :set_tuition, only: [:show, :edit, :update, :destroy]

  # GET /tuitions
  # GET /tuitions.json
  def index
    @tuitions = Tuition.all.decorate
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
    @tuition = Tuition.new(tuition_params)

    respond_to do |format|
      if @tuition.save
        format.html { redirect_to @tuition, notice: 'Tuition was successfully created.' }
        format.json { render action: 'show', status: :created, location: @tuition }
      else
        format.html { render action: 'new' }
        format.json { render json: @tuition.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tuitions/1
  # PATCH/PUT /tuitions/1.json
  def update
    respond_to do |format|
      if @tuition.update(tuition_params)
        format.html { redirect_to @tuition, notice: 'Tuition was successfully updated.' }
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

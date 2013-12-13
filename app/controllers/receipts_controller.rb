class ReceiptsController < ApplicationController

  before_action :set_tuition, only: [:index, :show, :edit, :create, :update, :new]
  before_action :set_receipt, only: [:show, :edit, :update, :destroy]

  def index
    #@receipts = @tuition.receipts.joins(:member).page(params[:page]).decorate
    @receipts = @tuition.receipts.joins(:member)
    @receipts = @receipts.merge(Member.number(params[:number]))
    @receipts = @receipts.merge(Member.name_like(params[:last_name_kana], nil))
    @receipts = @receipts.where(status: params[:status]) if params[:status].present?
    @receipts = @receipts.where(method: params[:method]) if params[:method].present?
    @receipts = @receipts.page(params[:page]).decorate
    @options_of_status = [["未払い", "0"], ["支払い済", "1"]]
    @options_of_method = [["銀行振込", "0"], ["現金払い", "1"]]
  end

  # GET /receipts/1
  # GET /receipts/1.json
  def show
  end

  # GET /receipts/new
  #def new
  #  @receipt = Receipt.new
  #end

  # GET /receipts/1/edit
  def edit
    @receipt.date ||= Date.today
  end

  # POST /receipts
  # POST /receipts.json
  #def create
  #  @receipt = Receipt.new(receipt_params)

  #  respond_to do |format|
  #    if @receipt.save
  #      format.html { redirect_to @receipt, notice: 'Receipt was successfully created.' }
  #      format.json { render action: 'show', status: :created, location: @receipt }
  #    else
  #      format.html { render action: 'new' }
  #      format.json { render json: @receipt.errors, status: :unprocessable_entity }
  #    end
  #  end
  #end

  # PATCH/PUT /receipts/1
  # PATCH/PUT /receipts/1.json
  def update
    respond_to do |format|
      if @receipt.update(receipt_params)
        format.html { redirect_to tuition_receipt_path(@tuition, @receipt), notice: '支払いを変更しました。' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @receipt.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /receipts/1
  # DELETE /receipts/1.json
  def destroy
    @receipt.destroy
    respond_to do |format|
      format.html { redirect_to receipts_url }
      format.json { head :no_content }
    end
  end

  def new
    @members = Member.new_members(@tuition.month.sub("/", "")).decorate
  end

  def create
    if params[:members].nil?
      redirect_to new_tuition_receipts_path(@tuition), flash: { alert: "会員を選んでください。" }
      return
    end
    month = @tuition.month.sub("/", "") if @tuition.month.length > 6
    ActiveRecord::Base.transaction do
      params[:members].each do |member_params|
        member = Member.find(member_params[:id])
        receipt = member.receipts.build(tuition_id: @tuition.id,
                                        member_id: member.id,
                                        method: Receipt::METHODS[:CASH],
                                        amount: 0,
                                        status: Receipt::STATUSES[:UNPAID])
        member.members_courses.active.each do |members_course|
          receipt.amount += members_course.fee(month)
        end
        receipt.save
      end
    end
    redirect_to tuition_receipts_path(@tuition)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tuition
      @tuition = Tuition.find(params[:tuition_id]).decorate
    end
    def set_receipt
      @receipt = Receipt.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def receipt_params
      params.require(:receipt).permit(:member_id, :amount, :method, :date, :status, :debit_id, :note)
    end
end

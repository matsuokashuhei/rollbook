class DebitsController < ApplicationController

  #before_action :set_debit, only: [:show, :edit, :update, :destroy]
  before_action :set_tuition, only: [:index, :bulk_edit, :bulk_update,]

  # GET /tuitions/:tuition_id/debits
  # GET /tuitions/:tuition_id/debits.json
  def index
    @debits = @tuition.debits.page(params[:page]).decorate
    #@debits = Debit.where(month: @month).page(params[:page]).decorate
  end

  def bulk_edit
    @debits = @tuition.debits.page(params[:page])
  end

  def bulk_update
    ActiveRecord::Base.transaction do
      params[:debits].each do |debit_params|
        debit = Debit.find(debit_params[:id])
        unless debit.status == debit_params[:status]
          debit.update_attributes!(status: debit_params[:status])
        end
      end
    end
    flash[:notice] = "更新しました。"
    redirect_to tuition_debits_path(@tuition)
  end

  def destroy_task
    ActiveRecord::Base.transaction do
      @task = Task.find(params[:task_id])
      @task.destroy
      Debit.where(month: @task.due_date.strftime("%Y/%m")).delete_all
      respond_to do |format|
        format.html { redirect_to debit_tasks_url }
        format.json { head :no_content }
      end
    end
  end


  def fix
    ActiveRecord::Base.transaction do
      respond_to do |format|
        task = Task.debit.find_by(due_date: (@month + "01").to_date)
        if task.update_attributes(status: "2")
          create_receipts!
          format.html { redirect_to debits_path(@month), notice: 'Debit was successfully updated.' }
        else
          format.html { render action: "index" }
        end
      end
    end
  end


  # GET /debits/1
  # GET /debits/1.json
  def show
  end

  # GET /debits/new
  def new
    @debit = Debit.new
  end


  # POST /debits
  # POST /debits.json
  def create
    @debit = Debit.new(debit_params)

    respond_to do |format|
      if @debit.save
        format.html { redirect_to @debit, notice: 'Debit was successfully created.' }
        format.json { render action: 'show', status: :created, location: @debit }
      else
        format.html { render action: 'new' }
        format.json { render json: @debit.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /debits/1
  # PATCH/PUT /debits/1.json
  def update
    respond_to do |format|
      if @debit.update(debit_params)
        format.html { redirect_to @debit, notice: 'Debit was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @debit.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /debits/1
  # DELETE /debits/1.json
  def destroy
    @debit.destroy
    respond_to do |format|
      format.html { redirect_to debits_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_debit
      @debit = Debit.find(params[:id])
    end
    def set_tuition
      @tuition = Tuition.find(params[:tuition_id]).decorate
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def debit_params
      params.require(:debit).permit(:bank_account_id, :month, :amount, :status, :note)
    end

    def create_receipts!
      date = (@month + "01").to_date
      # 口座あり
      members = Member.active.joins(bank_account: :debits).where("bank_accounts.status = ?", BankAccount::STATUSES[:ACTIVE]).where("debits.month = ?", @month)
      members.each do |member|
        receipt = member.receipts.build(month: @month)
        receipt.amount = member.total_monthly_fee(date)
        debit = member.bank_account.debits.find_by(month: @month)
        receipt.debit_id = debit.id
        if debit.status == Debit::STATUSES[:SUCCESS]
          receipt.method = Receipt::METHODS[:DEBIT]
          receipt.status = Receipt::STATUSES[:PAID]
        else
          receipt.method = Receipt::METHODS[:CASH]
          receipt.status = Receipt::STATUSES[:UNPAID]
        end
        receipt.save!
      end
      # 口座手続き中
      members = Member.active.joins(:bank_account).where("bank_accounts.status in (?)", BankAccount::not_active_statuses)
      members.each do |member|
        receipt = member.receipts.build(month: @month)
        receipt.amount = member.total_monthly_fee(date)
        receipt.method = Receipt::METHODS[:CASH]
        receipt.status = Receipt::STATUSES[:UNPAID]
        receipt.save!
      end
      # 口座なし
      members = Member.active.where(bank_account_id: nil)
      members.each do |member|
        receipt = member.receipts.build(month: @month)
        receipt.amount = member.total_monthly_fee(date)
        receipt.method = Receipt::METHODS[:CASH]
        receipt.status = Receipt::STATUSES[:UNPAID]
        receipt.save!
      end
    end
end

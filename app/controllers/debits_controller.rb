class DebitsController < ApplicationController
  before_action :set_debit, only: [:show, :edit, :update, :destroy]

  def tasks_index
    @tasks = Task.where(name: "debit").order("due_date DESC").decorate
    respond_to do |format|
      format.html { render action: "tasks/index" }
    end
  end

  def show_task
    @task = Task.find(params[:task_id])
    respond_to do |format|
      format.html { render action: "tasks/show" }
    end
  end

  def new_task
    @task = Task.new(name: "debit", frequency: "M", status: "1")
    respond_to do |format|
      format.html { render action: "tasks/new" }
    end
  end

  def edit_task
    @task = Task.find(params[:task_id])
    respond_to do |format|
      format.html { render action: "tasks/edit" }
    end
  end

  def create_task
    ActiveRecord::Base.transaction do
      @task = Task.new(task_params)
      @task.due_date = task_params[:due_date].to_date
      if @task.save
        BankAccount.active.with_members.each do |bank_account|
          amount = 0
          bank_account.members.each do |member|
            member.members_courses.active.joins(:course).each do |members_course|
              amount += members_course.course.monthly_fee
            end
          end
          debit = Debit.new(bank_account_id: bank_account.id,
                            month: @task.due_date.strftime("%Y/%m"),
                            amount: amount,
                            status: "1")
          until debit.save
            respond_to do |format|
              format.html { render action: 'new_task' }
              format.json { render json: @task.errors, status: :unprocessable_entity }
            end
          end
        end
      else
        respond_to do |format|
          format.html { render action: 'new_task' }
          format.json { render json: @task.errors, status: :unprocessable_entity }
        end
        return
      end
    end
    respond_to do |format|
      format.html { redirect_to debit_task_path(@task.id), notice: 'Task was successfully created.' }
      format.json { render action: 'show', status: :created, location: @task }
    end
  end

  def update_task
    task_params[:due_date] << "/01"
    respond_to do |format|
      ActiveRecord::Base.transaction do
        @task = Task.find(params[:task_id])
        if @task.update(task_params)
          if @task.status == "2"
            create_receipts(@task)
          end
          format.html { redirect_to debit_task_path(@task), notice: 'Debit was successfully updated.' }
          format.json { head :no_content }
        else
          format.html { render action: "tasks/edit" }
          format.json { render json: @task.errors, status: :unprocessable_entity }
        end
      end
    end
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

  def bulk_show
    month = params[:month][0..3] + "/" + params[:month][4..5]
    @task = Task.find_by(name: "debit", due_date: month + "/01")
    @debits = Debit.where(month: month).decorate
  end

  def bulk_edit
    bulk_show
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
    redirect_to debits_path(month: params[:month])
  end


  # GET /debits
  # GET /debits.json
  def index
    @debits = Debit.page(params[:page]).decorate
  end

  # GET /debits/1
  # GET /debits/1.json
  def show
  end

  # GET /debits/new
  def new
    @debit = Debit.new
  end

  # GET /debits/1/edit
  def edit
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

    # Never trust parameters from the scary internet, only allow the white list through.
    def debit_params
      params.require(:debit).permit(:bank_account_id, :month, :amount, :status, :note)
    end
    def task_params
      params.require(:task).permit(:name, :frequency, :due_date, :status, :note)
    end

    def create_receipts(task)
      month = task.due_date.strftime("%Y/%m")
      # 口座あり
      members = Member.active.joins(bank_account: :debits).where("bank_accounts.status = ?", BankAccount::STATUSES[:ACTIVE]).where("debits.month = ?", month)
      members.each do |member|
        receipt = member.receipts.build(month: month)
        receipt.amount = member.total_monthly_fee(task.due_date)
        debit = member.bank_account.debits.find_by(month: month)
        receipt.debit_id = debit.id
        if debit.status == Debit::STATUSES[:SUCCESS]
          receipt.method = Receipt::METHODS[:DEBIT]
          receipt.status = Receipt::STATUSES[:PAID]
        else
          receipt.method = Receipt::METHODS[:CASH]
          receipt.status = Receipt::STATUSES[:UNPAID]
        end
        receipt.save
      end
      # 口座手続き中
      members = Member.active.joins(:bank_account).where("bank_accounts.status in (?)", BankAccount::not_active_statuses)
      members.each do |member|
        receipt = member.receipts.build(month: month)
        receipt.amount = member.total_monthly_fee(task.due_date)
        receipt.method = Receipt::METHODS[:CASH]
        receipt.status = Receipt::STATUSES[:UNPAID]
        receipt.save
      end
      # 口座なし
      members = Member.active.where(bank_account_id: nil)
      members.each do |member|
        receipt = member.receipts.build(month: month)
        receipt.amount = member.total_monthly_fee(task.due_date)
        receipt.method = Receipt::METHODS[:CASH]
        receipt.status = Receipt::STATUSES[:UNPAID]
        receipt.save
      end
    end
end

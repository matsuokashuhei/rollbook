class BankAccountsController < ApplicationController
  before_action :set_bank_account, only: [:show, :edit, :update, :destroy, :members, :new_member, :create_member, :destroy_member]

  # GET /bank_accounts
  # GET /bank_accounts.json
  def index
    @bank_accounts = BankAccount.name_like(params[:holder_name_kana])
    if params[:receipt_date].present?
      @bank_accounts = @bank_accounts.where('to_char("receipt_date", \'YYYY/mm\') = ?', params[:receipt_date])
    end
    if params[:ship_date].present?
      @bank_accounts = @bank_accounts.where('to_char("ship_date", \'YYYY/mm\') = ?', params[:ship_date])
    end
    if params[:begin_date].present?
      @bank_accounts = @bank_accounts.where('to_char("begin_date", \'YYYY/mm\') = ?', params[:begin_date])
    end
    @bank_accounts = @bank_accounts.where(imperfect: params[:imperfect].present?)
    @bank_accounts = @bank_accounts.where(change_bank: params[:change_bank].present?)
    @bank_accounts = @bank_accounts.page(params[:page]).decorate
    #@bank_accounts = BankAccount.name_like(params[:holder_name_kana]).page(params[:page]).decorate
  end

  # GET /bank_accounts/1
  # GET /bank_accounts/1.json
  def show
  end

  # GET /bank_accounts/new
  def new
    @bank_account = BankAccount.new
    if params[:member_id]
      @member = Member.find(params[:member_id])
      @bank_account.holder_name = "#{@member.last_name}#{@member.first_name}"
      @bank_account.holder_name_kana = "#{@member.last_name_kana}#{@member.first_name_kana}"
    end
  end

  # GET /bank_accounts/1/edit
  def edit
  end

  # POST /bank_accounts
  # POST /bank_accounts.json
  def create
    @bank_account = BankAccount.new(bank_account_params)
    ActiveRecord::Base.transaction do
      respond_to do |format|
        if @bank_account.save
          if params[:member_id].present?
            member = Member.find(params[:member_id])
            member.update_attributes(bank_account_id: @bank_account.id)
            format.html { redirect_to member_path(member), notice: "口座を登録しました。" }
          else
            format.html { redirect_to @bank_account, notice: '口座を登録しました。' }
            format.json { render action: 'show', status: :created, location: @bank_account }
          end
        else
          format.html { render action: 'new' }
          format.json { render json: @bank_account.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PATCH/PUT /bank_accounts/1
  # PATCH/PUT /bank_accounts/1.json
  def update
    respond_to do |format|
      if @bank_account.update(bank_account_params)
        format.html { redirect_to @bank_account, notice: '口座を変更しました。' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @bank_account.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bank_accounts/1
  # DELETE /bank_accounts/1.json
  def destroy
    @bank_account.destroy if @bank_account.delete?
    respond_to do |format|
      format.html { redirect_to bank_accounts_url }
      format.json { head :no_content }
    end
  end

  def members
    @members = @bank_account.members.decorate
    respond_to do |format|
      format.html { render action: "members" }
    end
  end

  def new_member
    @members = Member.where(status: "1", bank_account_id: nil, leave_date: nil).decorate
    respond_to do |format|
      format.html { render action: "new_members" }
    end
  end

  def create_member
    if params[:member_id].nil?
      redirect_to new_bank_account_member_path(@bank_account)
      return
    end
    member = Member.find(params[:member_id])
    member.bank_account_id = params[:bank_account_id]
    respond_to do |format|
      if member.save
        format.html {
          redirect_to bank_account_members_path(@bank_account),
          notice: I18n.t("messages.controllers.bank_account.create_member", { holders_name: @bank_account.holder_name, member: member.full_name })
        }
        format.json { render action: 'show', status: :created, location: @bank_account }
      else
        format.html { render action: 'new_member' }
        format.json { render json: @bank_account.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy_member
    member = Member.find(params[:member_id])
    respond_to do |format|
      if member.update_attributes(bank_account_id: nil)
        format.html {
          redirect_to bank_account_members_path(@bank_account),
                      notice: I18n.t("messages.controllers.bank_account.destroy_member", { holders_name: @bank_account.holder_name, member: member.full_name })
        }
      else
        format.html { render action: 'new_member' }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bank_account
      @bank_account = BankAccount.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def bank_account_params
      params.require(:bank_account).permit(:holder_name,
                                           :holder_name_kana,
                                           :bank_id,
                                           :bank_name,
                                           :branch_id,
                                           :branch_name,
                                           :account_number,
                                           :receipt_date,
                                           :ship_date,
                                           :begin_date,
                                           :imperfect,
                                           :change_bank,
                                           :status,
                                           :note)
    end
end

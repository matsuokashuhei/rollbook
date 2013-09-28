class MembersController < ApplicationController
  before_action :set_member, only: [:show, :edit, :update, :destroy, :rolls, :bank_account]

  # GET /members
  # GET /members.json
  def index
    @members = Member.page(params[:page])
  end

  # GET /members/1
  # GET /members/1.json
  def show
  end

  # GET /members/new
  def new
    @member = Member.new
  end

  # GET /members/1/edit
  def edit
  end

  # POST /members
  # POST /members.json
  def create
    @member = Member.new(member_params)

    respond_to do |format|
      if @member.save
        #format.html { redirect_to @member, notice: 'Member was successfully created.' }
        format.html { redirect_to @member, notice: t("messages.controllers.defaults.create", { model: t("activerecord.models.member") }) }
        format.json { render action: 'show', status: :created, location: @member }
      else
        format.html { render action: 'new' }
        format.json { render json: @member.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /members/1
  # PATCH/PUT /members/1.json
  def update
    respond_to do |format|
      if @member.update(member_params)
        format.html { redirect_to @member, notice: t("messages.controllers.defaults.update", { model: t("activerecord.models.member") }) }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @member.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /members/1
  # DELETE /members/1.json
  def destroy
    @member.destroy if @member.delete?
    respond_to do |format|
      format.html { redirect_to members_url }
      format.json { head :no_content }
    end
  end

  # GET /members/1/rolls
  def rolls
    @rolls = Roll.details.where("rolls.member_id = ?", @member.id)
    respond_to do |format|
      format.html { render action: "rolls" }
    end
  end

  # GET /members/1/bank_account
  def bank_account
    @bank_account = @member.bank_account
    respond_to do |format|
      format.html { render action: "bank_account" }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_member
      @member = Member.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def member_params
      params.require(:member).permit(:first_name, :last_name, :first_name_kana, :last_name_kana, :gender, :birth_date, :zip, :address, :phone, :email_pc, :email_mobile, :note, :enter_date, :leave_date, :bank_account_id, :status, :nearby_station)
    end
end

class MembersController < ApplicationController
  before_action :set_member, only: [:show, :edit, :update, :destroy, :rolls, :recesses,]

  # GET /members
  # GET /members.json
  def index
    @q = Member.search(params[:q])
    @members = @q.result.order(:last_name_kana, :first_name_kana).page(params[:page]).decorate
  end

  # GET /members/1
  # GET /members/1.json
  def show
  end

  # GET /members/new
  def new
    @member = Member.new enter_date: Date.today, status: Member::STATUSES[:ADMISSION]
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
        format.html { redirect_to @member, notice: '会員を登録しました。' }
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
        format.html { redirect_to @member, notice: '会員を変更しました。' }
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
    @member.destroy if @member.destroy?
    respond_to do |format|
      format.html { redirect_to members_url }
      format.json { head :no_content }
    end
  end

  # GET /members/1/rolls
  def rolls
    @rolls = Roll.member(@member.id).details.merge(Lesson.for_month(params[:month].try(:gsub, '/', '')))
    @rolls = @rolls.where(lessons: { course_id: params[:course_id] }) if params[:course_id].present?
    @rolls = @rolls.where(status: params[:status]) if params[:status].present?
    @rolls = @rolls.merge(Lesson.order(date: :desc)).page(params[:page]).decorate
    respond_to do |format|
      format.html { render action: "rolls" }
    end
  end

  def recesses
    @recesses = Recess.joins(:members_course).where(members_courses: { member_id: @member.id })
    respond_to do |format|
      format.html { render action: "recesses" }
    end
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_member
      @member = Member.find(params[:id] || params[:member_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def member_params
      params.require(:member).permit(:number,
                                     :first_name,
                                     :last_name,
                                     :first_name_kana,
                                     :last_name_kana,
                                     :gender,
                                     :birth_date,
                                     :zip,
                                     :address,
                                     :phone_land,
                                     :phone_mobile,
                                     :email_pc,
                                     :email_mobile,
                                     :note,
                                     :enter_date,
                                     :leave_date,
                                     :bank_account_id,
                                     :status,
                                     :nearby_station)
    end
end

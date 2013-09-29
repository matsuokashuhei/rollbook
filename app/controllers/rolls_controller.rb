class RollsController < ApplicationController
  #before_action :set_roll, only: [:show, :edit, :update, :destroy]
  #before_action :set_lesson, only: [:edit, :update, :absence, :substitute]
  before_action :set_lesson, only: [:index, :new, :create, :edit, :create_or_update]

  # GET /lessons/:lesson_id/rolls
  # GET /lessons/:lesson_id/rolls.json
  def index
    if @lesson.status == "0" || @lesson.status == "1"
      @rolls = []
      MembersCourse.where(course_id: @lesson.course_id).term_dates(@lesson.date).each do |members_course|
        roll = Roll.find_or_initialize_by(lesson_id: @lesson.id, member_id: members_course.member_id)
        roll.status ||= "0"
        roll.status = "5" if Recess.exists?(members_course_id: members_course.id, month: @lesson.date.strftime("%Y/%m"))
        @rolls << roll
      end
      Roll.where(lesson_id: @lesson.id, status: "4").each do |roll|
        @rolls << roll
      end
      Roll.where(lesson_id: @lesson.id, status: "6").each do |roll|
        @rolls << roll
      end
    end
    if @lesson.status == "2"
      @rolls = @lesson.rolls
    end
  end

  # GET /rolls/1
  # GET /rolls/1.json
  def show
  end

  # GET /rolls/new
  def new
    #@roll = Roll.new
    unless params[:status].present?
      redirect_to edit_lesson_rolls_path(@lesson)
      return
    end
    @rolls = []
    if params[:status] == "2"
      # レッスンを欠席したメンバーを検索する。
      absence_rolls = Roll.absent.joins(:lesson).where("lessons.status = ?", "2").order("lessons.date", "rolls.id")
      # レッスンを欠席したメンバーの最古の欠席したレッスンを検索する。
      absence_rolls.each do |absence_roll|
        next if @lesson.course_id == absence_roll.lesson.course_id
        if @rolls.select { |roll| roll.member_id == absence_roll.member_id }.count == 0
          @rolls << absence_roll
        end
      end
      # ページネーションがない。
    end
    if params[:status] == "6"
      Member.where(status: "0").each do |member|
        @rolls << @lesson.rolls.build(member_id: member.id, status: "6") if member.rolls.count == 0
      end
      respond do |format|
        format.html { render action: "trial" }
      end
    end
  end

  # GET /lessons/:lesson_id/rolls/edit
  def edit
    #@rolls = @lesson.rolls
    index
  end

  # POST /rolls
  # POST /rolls.json
  def create
    ActiveRecord::Base.transaction do
      @lesson.update_attributes!(status: "1")
      params[:rolls].each do |roll_params|
        if roll_params[:status] == "2"
          Roll.find(roll_params[:id]).substitute(@lesson)
        else
          Roll.create(roll_params)
        end
      end
    end
    respond_to do |format|
      format.html { redirect_to lesson_rolls_path(@lesson) }
    end

#    @roll = Roll.new(roll_params)
#
#    respond_to do |format|
#      if @roll.save
#        format.html { redirect_to @roll, notice: 'Roll was successfully created.' }
#        format.json { render action: 'show', status: :created, location: @roll }
#      else
#        format.html { render action: 'new' }
#        format.json { render json: @roll.errors, status: :unprocessable_entity }
#      end
#    end
  end

  # PATCH/PUT /rolls/1
  # PATCH/PUT /rolls/1.json
  def update
    ActiveRecord::Base.transaction do
      @lesson.update_attributes(status: "1")
      params[:rolls].each do |roll_params|
        roll = Roll.find(roll_params[:id])
        roll.update_attributes(status: roll_params[:status])
      end
    end
    respond_to do |format|
      format.html { redirect_to lesson_rolls_url(@lesson) }
    end
  end

  # DELETE /rolls/1
  # DELETE /rolls/1.json
  def destroy
    @roll.destroy
    respond_to do |format|
      format.html { redirect_to rolls_url }
      format.json { head :no_content }
    end
  end

  # POST /lesson/:lesson_id/rolls
  def create_or_update
    ActiveRecord::Base.transaction do
      @lesson.update_attributes(status: "1")
      params[:rolls].each do |roll_params|
        roll = Roll.find_or_initialize_by(lesson_id: @lesson.id, member_id: roll_params[:member_id])
        roll.status = roll_params[:status]
        if roll.status != "9"
          roll.save
        elsif roll.substitute_roll_id.blank?
          roll.update_attributes(status: "0")
        else
          roll.cancel_substitute
        end
      end
    end
    respond_to do |format|
      format.html { redirect_to lesson_rolls_url(@lesson) }
    end
  end

  #def substitute
  #  params[:rolls].each do |roll|
  #    Roll.find(roll[:id]).substitute!(@lesson)
  #  end
  #  respond_to do |format|
  #    format.html { redirect_to lesson_rolls_url(@lesson) }
  #  end
  #end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_lesson
      @lesson = Lesson.find(params[:lesson_id])
    end

    def set_roll
      @roll = Roll.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def roll_params
      params.require(:roll).permit(:lesson_id, :member_id, :status, :substitute_roll_id)
    end

end

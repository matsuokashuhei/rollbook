class MembersCoursesController < ApplicationController

  before_action :set_member
  before_action :set_members_course, only: [:show, :edit, :update, :destroy, :rolls]

  # GET /members_courses
  # GET /members_courses.json
  def index
    if params[:status] == '1'
      @members_courses = @member.members_courses.will_active(Date.today).details.order(begin_date: :desc)
      @members_courses += @member.members_courses.active(Date.today).details.order(begin_date: :desc)
    elsif params[:status] == '9'
      @members_courses = @member.members_courses.deactive(Date.today).details.order(begin_date: :desc)
    else
      @members_courses = @member.members_courses.details.order(begin_date: :desc)
    end
  end

  # GET /members_courses/1
  # GET /members_courses/1.json
  def show
    @course = CoursesQuery.course(@members_course.course_id)
  end

  # GET /members_courses/new
  def new
    @members_course = @member.members_courses.build
    @course = {}
    if params[:course_id].present?
      @members_course.course_id = params[:course_id]
      @course = CoursesQuery.course(params[:course_id])
    end
    @courses = CoursesQuery.courses
  end

  # GET /members_courses/1/edit
  def edit
    @course = CoursesQuery.course(@members_course.course_id)
  end

  # POST /members_courses
  # POST /members_courses.json
  def create
    @members_course = MembersCourse.new(members_course_params)
    @course = {}
    if @members_course.course_id.present?
      @course = CoursesQuery.course(@members_course.course_id)
    end
    @courses = CoursesQuery.courses

    respond_to do |format|
      if @members_course.save
        format.html { redirect_to member_members_course_url(@member, @members_course), notice: '受講クラスを登録しました。' }
        format.json { render action: 'show', status: :created, location: @members_course }
      else
        format.html { render action: 'new' }
        format.json { render json: @members_course.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /members_courses/1
  # PATCH/PUT /members_courses/1.json
  def update
    @course = CoursesQuery.course(@members_course.course_id)
    respond_to do |format|
      if @members_course.update(members_course_params)
        format.html { redirect_to member_members_course_url(@member, @members_course), notice: '受講クラスを変更しました。' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @members_course.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /members_courses/1
  # DELETE /members_courses/1.json
  def destroy
    if @members_course.deletable?
      ActiveRecord::Base.transaction do
        rolls = MembersQuery.new(@member).find_rolls(@members_course)
        rolls.each do |roll|
          roll.destroy!
        end
        @members_course.destroy!
      end
      respond_to do |format|
        format.html { redirect_to member_members_courses_url(@member), notice: '受講クラスを削除しました。' }
        format.json { head :no_content }
      end
    else
      respond_to do |format|
        format.html { redirect_to member_members_courses_url(@member) }
        format.json { head :no_content }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_member
      @member = Member.find(params[:member_id])
    end
    def set_members_course
      @members_course = MembersCourse.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def members_course_params
      params.require(:members_course).permit(:member_id, :course_id, :begin_date, :end_date, :note, :introduction)
    end
end

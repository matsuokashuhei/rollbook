class MembersCoursesController < ApplicationController
  helper RollsHelper

  before_action :set_member
  before_action :set_members_course, only: [:show, :edit, :update, :destroy, :rolls]
  before_action :set_courses, only: [:new, :create]

  # GET /members_courses
  # GET /members_courses.json
  def index
    @members_courses = MembersCourse.details.where("members_courses.member_id = ?", @member.id)
  end

  # GET /members_courses/1
  # GET /members_courses/1.json
  def show
  end

  # GET /members_courses/new
  def new
    @member = Member.find(params[:member_id])
    @members_course = @member.members_courses.build(course_id: params[:course_id])
  end

  # GET /members_courses/1/edit
  def edit
  end

  # POST /members_courses
  # POST /members_courses.json
  def create
    @member = Member.find(params[:member_id])
    @members_course = MembersCourse.new(members_course_params)

    respond_to do |format|
      if @members_course.save
        format.html { redirect_to member_members_course_url(@member, @members_course), notice: 'Members course was successfully created.' }
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
    respond_to do |format|
      if @members_course.update(members_course_params)
        format.html { redirect_to member_members_course_url(@member, @members_course), notice: 'Members course was successfully updated.' }
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
    @members_course.destroy
    respond_to do |format|
      format.html { redirect_to member_members_courses_url(@member) }
      format.json { head :no_content }
    end
  end

  def rolls
    @rolls = @members_course.rolls
    respond_to do |format|
      format.html { render aciton: "rolls" }
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

    def set_courses
      @schools = School.includes(studios: [timetables: [:courses, :time_slot]]).order("schools.open_date, studios.open_date, time_slots.start_time, timetables.weekday")
      @courses = Course.joins(:instructor, :dance_style, :level).term_dates(Date.today)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def members_course_params
      params.require(:members_course).permit(:member_id, :course_id, :begin_date, :end_date, :note, :introduction)
    end
end

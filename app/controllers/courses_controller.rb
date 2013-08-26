class CoursesController < ApplicationController
  before_action :set_course, only: [:show, :edit, :update, :destroy]

  # GET /courses
  # GET /courses.json
  def index
    if params[:date].blank?
      redirect_to courses_url(date: Date.today.strftime("%Y%m%d"))
      return
    end
    @schools = School.includes(studios: [timetables: [:courses, :time_slot]]).order("schools.open_date, studios.open_date, time_slots.start_time, timetables.weekday" )
    @courses = Course.joins(:instructor, :dance_style, :level).date_is(params[:date].to_date)
    @active_school_id = School.first.id
  end

  # GET /courses/1
  # GET /courses/1.json
  def show
    @course = Course.joins([timetable: [[studio: :school], :time_slot]], :instructor, :dance_style, :level).find(params[:id])
  end

  # GET /courses/new
  def new
    @course = Course.new
  end

  # GET /courses/1/edit
  def edit
  end

  # POST /courses
  # POST /courses.json
  def create
    @course = Course.new(course_params)

    respond_to do |format|
      if @course.save
        format.html { redirect_to @course, notice: 'Course was successfully created.' }
        format.json { render action: 'show', status: :created, location: @course }
      else
        format.html { render action: 'new' }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /courses/1
  # PATCH/PUT /courses/1.json
  def update
    respond_to do |format|
      if @course.update(course_params)
        format.html { redirect_to @course, notice: 'Course was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /courses/1
  # DELETE /courses/1.json
  def destroy
    @course.destroy
    respond_to do |format|
      format.html { redirect_to courses_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_course
      @course = Course.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def course_params
      params.require(:course).permit(:timetable_id, :instructor_id, :dance_style_id, :level_id, :age_group_id, :open_date, :close_date, :note, :monthly_fee)
    end
end

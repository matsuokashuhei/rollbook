class CoursesController < ApplicationController
  before_action :set_course, only: [:show, :edit, :update, :destroy, :members, :lessons]

  def schools
    @schools = School.all
    respond_to do |format|
      format.html { render action: "schools" }
    end
  end

  # GET /courses
  # GET /courses.json
  def index
    if params[:date].blank? || params[:studio_id].blank?
      redirect_to schools_path
      return
    end
    @current_date = params[:date].to_date
    @studio = Studio.find(params[:studio_id])
    @timetables = @studio.timetables.joins(:time_slot).order("time_slots.start_time, timetables.weekday")
    @courses = Course.joins(:instructor, :dance_style, :level).active(@current_date).decorate
    @before_month = (@current_date - 1.month).beginning_of_month
    @next_month = (@current_date + 1.month).beginning_of_month
  end

  # GET /courses/1
  # GET /courses/1.json
  def show
    @course = Course.joins([timetable: [[studio: :school], :time_slot]], :instructor, :dance_style, :level).find(params[:id])
    @studio = @course.timetable.studio
  end

  # GET /courses/new
  def new
    @course = Course.new(timetable_id: params[:timetable_id])
    @studio = Timetable.find(params[:timetable_id]).studio
  end

  # GET /courses/1/edit
  def edit
    @studio = @course.timetable.studio
  end

  # POST /courses
  # POST /courses.json
  def create
    @course = Course.new(course_params)

    respond_to do |format|
      if @course.save
        format.html { redirect_to @course, notice: 'クラスを登録しました。' }
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
        format.html { redirect_to @course, notice: 'クラスを変更しました。' }
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

  def members
    @studio = @course.timetable.studio
    @members_courses = MembersCourse.joins(:member).where("members_courses.course_id = ?", @course.id).order("members_courses.begin_date", "members.id")
    respond_to do |format|
      format.html { render action: "members" }
    end
  end

  def lessons
    @studio = @course.timetable.studio
    @lessons = @course.lessons.decorate
    respond_to do |format|
      format.html { render action: "lessons" }
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

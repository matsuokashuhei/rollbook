class CoursesController < ApplicationController

  before_action :set_course, only: [:show, :edit, :update, :destroy, :members, :lessons]

  # GET /courses
  # GET /courses.json
  def index
    # スタジオのタブの情報を作る。
    @current_date = params[:date].try(:to_date) || Date.today
    @studios = Studio.joins(:school).merge(School.where('coalesce(schools.close_date,now()) > ?', @current_date).order(:open_date)).order(:open_date)
    if params[:studio_id].blank? || params[:date].blank?
      studio = @studios.find {|studio| studio.school_id == current_user.school_id } || @studios.first
      redirect_to courses_path(studio_id: studio.id, date: @current_date.to_s(:number)) and return
    end
    @current_studio = @studios.find {|studio| studio.id == params[:studio_id].to_i }
    # スタジオのタイムテーブルの情報を作る。
    @courses = CoursesQuery.courses(@current_studio, @current_date)
    @before_month = (@current_date - 1.month).beginning_of_month
    @next_month = (@current_date + 1.month).beginning_of_month
  end

  # GET /courses/1
  # GET /courses/1.json
  def show
    redirect_to courses_path if params[:id].nil? || Course.exists?(params[:id]).!
    @timetable = TimetablesQuery.timetable(@course.timetable_id)
    # スタジオのタブの情報を作る。
    @studio = Timetable.find(@timetable.id).studio
  end

  # GET /courses/new
  def new
    redirect_to courses_path if params[:timetable_id].nil?
    @studio = Timetable.find(params[:timetable_id]).studio
    # クラスの情報を作る。
    @course = Course.new(timetable_id: params[:timetable_id])
    @timetable = TimetablesQuery.timetable(params[:timetable_id])
  end

  # GET /courses/1/edit
  def edit
    redirect_to courses_path if params[:id].nil? || Course.exists?(params[:id]).!
    @timetable = TimetablesQuery.timetable(@course.timetable_id)
    @studio = Timetable.find(@timetable.id).studio
  end

  # POST /courses
  # POST /courses.json
  def create
    @course = Course.new(course_params)
    #@timetable = TimetablesQuery.timetable(params[:timetable_id])
    @timetable = TimetablesQuery.timetable(@course.timetable_id)
    @studio = @course.timetable.studio
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
    @studio = @course.timetable.studio
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
    if params[:status] == '1'
      @members_courses = MembersCourse.joins(:member).where(members_courses: { course_id: @course.id }).active(Date.today).order(:begin_date).decorate
    elsif params[:status] == '9'
      @members_courses = MembersCourse.joins(:member).where(members_courses: { course_id: @course.id }).deactive(Date.today).order(:begin_date).decorate
    else
      @members_courses = MembersCourse.joins(:member).where(members_courses: { course_id: @course.id }).order(:begin_date).decorate
    end

    respond_to do |format|
      format.html { render action: "members" }
    end
  end

  def lessons
    @studio = @course.timetable.studio
    @lessons = @course.lessons.merge(Lesson.order(date: :desc)).page(params[:page]).decorate
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

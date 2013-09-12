class LessonsController < ApplicationController
  before_action :set_lesson, only: [:show, :edit, :update, :destroy]

  # GET /lessons
  # GET /lessons.json
  def index
    if params[:month].blank? and params[:date].blank?
      redirect_to lessons_url(month: Date.today.strftime("%Y%m"))
      return
    end
    if params[:month].present?
      year = params[:month].slice(0, 4).to_i
      month = params[:month].slice(4, 2).to_i
      @begin_date = Date.new(year, month, 1)
      @end_date = @begin_date.end_of_month
      dates = (@begin_date..@end_date).map {|date| date }
      cwday = 1
      while cwday < @begin_date.cwday
        dates.unshift(nil)
        cwday += 1
      end
      cwday = @end_date.cwday
      while cwday < 7
        dates.push(nil)
        cwday += 1
      end
      @weeks = dates.each_slice(7).map {|week| week }
      @month = params[:month]
      respond_to do |format|
        format.html { render action: "calendar" }
      end
      return
    end
    if params[:date].present?
      @date = params[:date].to_date
      @courses = Course.joins([timetable: [[studio: :school], :time_slot]], :instructor, :dance_style, :level).date_is(@date).where("timetables.weekday = ?", @date.cwday).order("schools.open_date, studios.open_date, time_slots.start_time")
      @lessons = []
      @courses.each do |course|
        attributes = { date: @date, course_id: course.id }
        if @date < Date.today + 7.day
          @lessons << Lesson.where(attributes).find_or_create_by(attributes.merge!({ status: "0" }))
        else
          @lessons << Lesson.where(attributes).first_or_create(attributes.merge!({ status: "0" }))
        end
      end
    end
  end

  # GET /lessons/1
  # GET /lessons/1.json
  def show
  end

  # GET /lessons/new
  def new
    @lesson = Lesson.new
  end

  # GET /lessons/1/edit
  def edit
  end

  # POST /lessons
  # POST /lessons.json
  def create
    @lesson = Lesson.new(lesson_params)

    respond_to do |format|
      if @lesson.save
        format.html { redirect_to @lesson, notice: 'Lesson was successfully created.' }
        format.json { render action: 'show', status: :created, location: @lesson }
      else
        format.html { render action: 'new' }
        format.json { render json: @lesson.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /lessons/1
  # PATCH/PUT /lessons/1.json
  def update
    respond_to do |format|
      if @lesson.update(lesson_params)
        format.html { redirect_to @lesson, notice: 'Lesson was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @lesson.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lessons/1
  # DELETE /lessons/1.json
  def destroy
    @lesson.destroy
    respond_to do |format|
      format.html { redirect_to lessons_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_lesson
      @lesson = Lesson.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def lesson_params
      params.require(:lesson).permit(:course_id, :date, :status, :note)
    end
end

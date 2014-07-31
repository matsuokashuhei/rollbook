class LessonsController < ApplicationController
  before_action :set_lesson, only: [:show, :edit, :update, :destroy, :fix, :cancel]
  before_action :require_month_or_date, only: [:index]

  # GET /lessons
  # GET /lessons.json
  def index
    return calendar if params[:month].present?
    @lessons = []
    @date = params[:date].to_date
    return if Holiday.exists? date: @date
    @courses = LessonsQuery.find_lessons(params[:school_id], @date)
    @courses.each do |course|
      lesson = Lesson.find_or_initialize_by(date: @date, course_id: course.id) do |l|
        l.status = Lesson::STATUS[:UNFIXED]
        l.rolls_status = Lesson::ROLLS_STATUS[:NONE]
      end
      @lessons << lesson.decorate
    end
    @lessons
  end

  # GET /lessons/1
  # GET /lessons/1.json
  def show
    redirect_to lesson_rolls_path(@lesson)
  end

  # GET /lessons/new
  def new
    # TODO 使っていないから削除する。
    @lesson = Lesson.new
  end

  # GET /lessons/1/edit
  def edit
    # TODO 使っていないから削除する。
  end

  # POST /lessons
  # POST /lessons.json
  def create
    @lesson = Lesson.find_or_initialize_by(course_id: params[:lesson][:course_id], date: params[:lesson][:date]) do |lesson|
      lesson.status = params[:lesson][:status]
      lesson.rolls_status = params[:lesson][:rolls_status]
    end
    if @lesson.new_record?
      @lesson.save!
    end
    redirect_to lesson_rolls_path(@lesson)
  end

  # PATCH/PUT /lessons/1
  # PATCH/PUT /lessons/1.json
  def update
    # TODO 使っていないから削除する。
    respond_to do |format|
      if @lesson.update(lesson_params)
        #format.html { redirect_to @lesson, notice: 'Lesson was successfully updated.' }
        format.html { redirect_to lessons_path(date: @lesson.date.strftime("%Y%m%d")) }
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
    # TODO 使っていないから削除する。
    @lesson.destroy
    respond_to do |format|
      format.html { redirect_to lessons_url }
      format.json { head :no_content }
    end
  end

  # POST /lessons/1/fix
  def fix
    if @lesson.fix?
      @lesson.fix
      notice = "レッスンを確定しました。"
    end
    respond_to do |format|
      format.html { redirect_to lesson_rolls_url(@lesson), notice: notice }
    end
  end

  def cancel
    return redirect_to lesson_rolls_path(@lesson) if params[:status].blank?
    return redirect_to lesson_rolls_path(@lesson) if @lesson.fixed?
    ActiveRecord::Base.transaction do
      @lesson.update_attributes status: params[:status], rolls_status: "1"
      @lesson.reset_rolls.each do |roll|
        roll.status = "6" if roll.status == "0" && @lesson.status != "1"
        roll.status = "0" if roll.status == "0" && @lesson.status == "1"
        roll.save
      end
    end
    redirect_to lesson_rolls_path(@lesson)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_lesson
      @lesson = Lesson.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def lesson_params
      params.require(:lesson).permit(:course_id, :date, :rolls_status, :status, :note)
    end

    def require_month_or_date
      return redirect_to lessons_path(month: Date.today.strftime("%Y%m")) if params[:month].blank? && params[:date].blank?
    end

    def calendar
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
      @holidays = Holiday.where('"date" between ? and ?', @begin_date, @end_date).pluck(:date)
      @month = params[:month]
      respond_to do |format|
        format.html { render action: "calendar" }
      end
    end

end

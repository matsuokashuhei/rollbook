class LessonsController < ApplicationController
  before_action :set_date, only: [:index,]
  before_action :set_lesson, only: [:show, :fix, :unfix, :cancel,]

  # GET /lessons
  # GET /lessons.json
  def index
    # 営業日であるか判定する。
    if Holiday.holiday?(@date)
      @lessons = Lesson.none.decorate
      return
    end
    # @dateのクラスを検索する。
    @courses = if params[:school_id].present?
        Course.lesson_of_day(@date).where(schools: { id: params[:school_id] })
      else
        Course.lesson_of_day(@date)
      end
    # クラスのレッスンを検索または作成する。
    @lessons = @courses.map do |course|
        Lesson.find_or_initialize_by(date: @date, course_id: course.id) do |lesson|
          lesson.status = Lesson::STATUS[:UNFIXED]
          lesson.rolls_status = Lesson::ROLLS_STATUS[:NONE]
        end.decorate
      end
  end

  # GET /lessons/1
  # GET /lessons/1.json
  def show
    redirect_to lesson_rolls_path(@lesson)
  end

  # POST /lessons
  # POST /lessons.json
  def create
    @lesson = Lesson.find_or_create_by(course_id: lesson_params[:course_id], date: lesson_params[:date].to_date) do |lesson|
        lesson_params[:date] = lesson_params[:date].to_date
        lesson.update(lesson_params)
      end
    redirect_to lesson_rolls_path(@lesson)
  end

  # POST /lessons/1/fix
  def fix
    if @lesson.fixable?
      @lesson.fix
      notice = "レッスンを確定しました。"
    end
    respond_to do |format|
      format.html { redirect_to lesson_rolls_url(@lesson), notice: notice }
    end
  end
  
  def unfix
    @lesson.unfix
    notice = "確定を解除しました。"
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
    def set_date
      #@month = Date.today.strftime('%Y%m') unless params.has_key?(:month)
      #@date = Date.today unless params.has_key?(:date)
      if [params[:month].blank?, params[:date].blank?].all?
        return redirect_to lessons_path(month: Date.today.strftime('%Y%m'))
      end
      begin
        if params.has_key?(:month)
          "#{params[:month]}01".to_date
          return calendar
        end
        @date = params[:date].to_date
      rescue
        return redirect_to lessons_path(month: Date.today.strftime('%Y%m'))
      end
    end
  
    def set_lesson
      @lesson = Lesson.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def lesson_params
      params.require(:lesson).permit(:course_id, :date, :rolls_status, :status, :note)
    end

    def calendar
      dates = Rollbook::Util::Month.days_of_month(params[:month])
      (1...dates.first.cwday).map { dates.unshift(nil) }
      (dates.last.cwday...7).map { dates.push(nil) }
      @weeks = dates.each_slice(7).map {|week| week }
      respond_to do |format|
        format.html { render action: "calendar" }
      end
    end

end

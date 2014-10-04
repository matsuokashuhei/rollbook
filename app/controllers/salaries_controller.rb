class SalariesController < ApplicationController

  before_action :admin_user!

  def index
    @q = Instructor.search(params[:q])
    @month = params[:month]
    @instructors = @q.result.joins(:courses).merge(Course.active("#{@month}01".to_date)).order(:name).uniq.page(params[:page]).decorate
  end

  def show
    if params[:month].nil? || params[:instructor_id].nil?
      redirect_to sararies_path and return
    end
    @month = params[:month]
    @instructor = Instructor.find params[:instructor_id]
    @beginning_of_month = (@month + "01").to_date
    @end_of_month = @beginning_of_month.end_of_month
    @courses = @instructor.courses.active(@end_of_month).details.merge(Studio.order(:open_date)).merge(Timetable.order(:weekday)).merge(TimeSlot.order(:start_time))
    respond_to do |f|
      f.html
      f.pdf do
        filename = "#{@beginning_of_month.strftime('%Y年%m月')}_#{@instructor.name}"
        render pdf: filename,
               encoding: 'UTF-8',
               #layout: 'pdf.html.erb',
               template: 'salaries/pay_statement'
      end
    end
  end

  private

end

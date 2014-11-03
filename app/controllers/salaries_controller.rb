class SalariesController < ApplicationController

  #before_action :admin_user!
  before_action :manager!

  def index
    @q = Instructor.search(params[:q])
    @month = params[:month]
    @instructors = @q.result.joins(:courses).merge(Course.active("#{@month}01".to_date)).order(:name).uniq.page(params[:page]).decorate
  end

  def show
    if [params[:month].nil?, params[:instructor_id].nil?].any?
      redirect_to sararies_path and return
    end
    @month = params[:month]
    @instructor = Instructor.find params[:instructor_id]
    end_of_month = Date.new(@month[0, 4].to_i, @month[4, 2].to_i, 1).end_of_month
    @courses = @instructor.courses.active(end_of_month).details.merge(Studio.order(:open_date)).merge(Timetable.order(:weekday)).merge(TimeSlot.order(:start_time))
    respond_to do |f|
      f.html
      f.pdf do
        filename = "#{end_of_month.strftime('%Y年%m月')}_#{@instructor.name}先生"
        render pdf: filename,
               encoding: 'UTF-8',
               template: 'salaries/show'
      end
    end
  end

  private

end

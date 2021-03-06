class SalariesController < ApplicationController

  #before_action :admin_user!
  before_action :manager!

  def index
    @q = Instructor.ransack(params[:q])
    @month = params[:month]
    @instructors = @q.result
                     .joins(:courses)
                     .merge(Course.opened("#{@month}01".to_date))
                     .order(:name)
                     .uniq.yield_self { |array|
                       Kaminari.paginate_array(array)
                     }.page(params[:page])
                     .yield_self { |paginate_array|
                       InstructorDecorator.decorate_collection(paginate_array)
                     }
  end

  def show
    if [params[:month].nil?, params[:instructor_id].nil?].any?
      redirect_to sararies_path and return
    end
    @month = params[:month]
    @instructor = Instructor.find params[:instructor_id]
    end_of_month = Date.new(@month[0, 4].to_i, @month[4, 2].to_i, 1).end_of_month
    @courses = @instructor.courses.opened(end_of_month).details.merge(Studio.order(:open_date)).merge(Timetable.order(:weekday)).merge(TimeSlot.order(:start_time))
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

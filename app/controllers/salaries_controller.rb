class SalariesController < ApplicationController

  before_action :admin_user!

  def index
    if params[:month].present?
      params[:q] = { month: params[:month] }
    end
    if params[:q].blank? || params[:q][:month].blank?
      @month = (Date.today - 1.month).strftime('%Y%m')
      redirect_to salaries_path('q[month]' => @month) and return
    end
    @month = params[:q][:month]
    @q = Instructor.search(params[:q])
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
    @courses = @instructor.courses.active(@end_of_month).details
  end

  private

end

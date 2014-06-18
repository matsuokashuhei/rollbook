class SalariesController < ApplicationController
  before_action :admin_user!
  before_action :set_month

  def index
    @beginning_of_month = (@month + "01").to_date
    @instructors = Instructor.search(params[:name]).joins(:courses).merge(Course.active(@beginning_of_month)).unscope(:order).uniq.page(params[:page]).decorate
  end

  def show
    @instructor = Instructor.find params[:instructor_id]
    @beginning_of_month = (@month + "01").to_date
    @end_of_month = @beginning_of_month.end_of_month
    @courses = @instructor.courses.active(@end_of_month).details
  end

  private
    def set_month
      @month = params[:month]
    end
end

class SalariesController < ApplicationController
  before_action :set_month

  def index
    @target_date = (@month + "01").to_date
    @instructors = Instructor.search(params[:name]).joins(:courses).merge(Course.active(@target_date)).unscope(:order).uniq.page(params[:page]).decorate
  end

  def show
    @instructor = Instructor.find params[:instructor_id]
    @target_date = (@month + "01").to_date
    @courses = @instructor.courses.active(@target_date).details
  end

  private
    def set_month
      @month = params[:month]
    end
end

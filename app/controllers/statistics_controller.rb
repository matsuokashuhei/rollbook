class StatisticsController < ApplicationController
  before_action :admin_user!

  def index
    @months = []
    start_date = Date.new(2013, 5, 1)
    end_date = Date.today
    while start_date.strftime("%Y%m") <= end_date.strftime("%Y%m")
      @months << start_date.strftime("%Y%m")
      start_date += 1.month
    end
    @schools = School.all
  end

  def members
    case params[:status]
    when "registered"
      @members = Member.registered(params[:month]).decorate
    when "active"
      active = Member.active(params[:month]).pluck(:id)
      registered = Member.registered(params[:month]).pluck(:id)
      canceled = Member.canceled(params[:month]).pluck(:id)
      active = active - registered
      active = active - canceled
      @members = Member.where(id: active).decorate
    when "canceled"
      @members = Member.canceled(params[:month]).decorate
    end
  end

end

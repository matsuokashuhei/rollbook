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

  def members_courses
    case params[:status]
    when "registered"
      @members_courses = MembersCourse.registered(params[:month]).joins([course: [timetable: [studio: :school]]], :member).where(schools: { id: params[:school_id] })
    when "canceled"
      @members_courses = MembersCourse.canceled(params[:month]).joins([course: [timetable: [studio: :school]]], :member).where(schools: { id: params[:school_id] })
    end
  end

  def recesses
    end_of_month = (params[:month] + "01").to_date.end_of_month
    @recesses = Recess.where(month: params[:month]).joins(members_course: [course: [timetable: [studio: :school]]]).merge(MembersCourse.active(end_of_month)).where(schools: { id: params[:school_id] })
  end

  def courses
    return redirect_to statistics_path if params[:year].blank?
    @start_date = Date.new(params[:year].to_i, 4, 1)
    @end_date = (@start_date + 12.month).end_of_month
    # 開始日がTOより過去で、終了日がFROMより未来のクラスを検索する。
    @courses = Course.where('"courses"."open_date" < ? and coalesce("courses"."close_date", \'9999-12-31\') > ?', @end_date, @start_date).details.merge(School.order(:open_date)).merge(Studio.order(:open_date)).merge(Timetable.order(:weekday)).merge(TimeSlot.order(:start_time)).order(:open_date)
    @months = [*0..11].map {|i| @start_date + i.month }
  end

end

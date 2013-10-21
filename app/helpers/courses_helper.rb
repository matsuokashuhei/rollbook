module CoursesHelper
  def schools_link
    link_to t("activerecord.models.school"), schools_path
  end

  def courses_link(date: Date.today)
    link_to t("activerecord.models.course"), courses_path(date: date.strftime("%Y%m%d"))
  end
end

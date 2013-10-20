module CoursesHelper
  def courses_link
    link_to t("activerecord.models.course"), courses_path
  end
end

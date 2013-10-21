module LessonsHelper

  def lessons_link
    link_to t("activerecord.models.lesson"), lessons_path
  end

  def course_lessons_link(course, disable: false)
    unless disable
      link_to t("activerecord.models.lesson"), lessons_path
    else
      link_to t("activerecord.models.lesson"), nil, class: "disabled"
    end
  end

end

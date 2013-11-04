module CoursesHelper

  def list_item_to_schools(active: false)
    text = t("activerecord.models.school")
    if active
      content_tag :li, text, class: "active"
    else
      content_tag :li, schools_link
    end

  end

  def list_item_to_courses(studio, date: Date.today, active: false)
    text = "#{studio.school.name}#{studio.name}"
    if active
      content_tag :li, text, class: "active"
    else
      content_tag :li do
        link_to text, courses_path(studio_id: studio.id, date: date.strftime("%Y%m%d"))
      end
    end
  end

  def list_item_to_course(course, active: false)
    text = course.decorate.name
    if active
      content_tag :li, text, class: "active"
    else
      content_tag :li, course_link(course)
    end

  end

  def schools_link
    link_to t("activerecord.models.school"), schools_path
  end

  def courses_link(studio, date: Date.today)
    if date.present?
      link_to "#{studio.school.name}#{studio.name}", courses_path(studio_id: studio.id, date: date.strftime("%Y%m%d"))
    else
      link_to "#{studio.school.name}#{studio.name}", courses_path(studio_id: studio.id, date: Date.today.strftime("%Y%m%d"))
    end
  end

  def instructor_courses_link(instructor, disable: false)
    unless disable
      link_to t("activerecord.models.course"), instructor_courses_path(instructor)
    else
      link_to t("activerecord.models.course"), nil, class: "disabled"
    end
  end

  def course_link(course)
    link_to course.decorate.name, course_path(course)
  end
end

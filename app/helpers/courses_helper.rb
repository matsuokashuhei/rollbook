module CoursesHelper

  # パン屑用
  def list_item_to_courses(studio, date: Date.today, active: false)
    if active
      content_tag :li, studio.name, class: "active"
    else
      content_tag :li do
        link_to studio.name, courses_path(studio_id: studio.id, date: date.strftime("%Y%m%d"))
      end
    end
  end

  def list_item_to_course(course, active: false)
    text = course.decorate.name
    if active
      content_tag :li, text, class: "active"
    else
      content_tag :li, link_to_course(course)
    end

  end

  # タブ用
  def tab_to_course course, active: false
    text = t("activerecord.models.course")
    if active
      content_tag :li, class: "active" do
        link_to text, '#course', data: { toggle: "tab" }
      end
    else
      content_tag :li do
        link_to text, course_path(course)
      end
    end
  end

  def tab_to_courses_members course, active: false
    text = t("activerecord.models.member")
    if active
      content_tag :li, class: "active" do
        link_to text, '#member', data: { toggle: "tab" }
      end
    else
      content_tag :li do
        link_to text, course_members_path(course)
      end
    end
  end

  def tab_to_courses_lessons course, active: false
    text = t "activerecord.models.lesson"
    if active
      content_tag :li, class: "active" do
        link_to text, '#lesson', data: { toggle: "tab" }
      end
    else
      content_tag :li do
        link_to text, course_lessons_path(course)
      end
    end
  end

  def link_to_schools
    link_to t("activerecord.models.school"), schools_path
  end

  def instructor_courses_link(instructor, disable: false)
    unless disable
      link_to t("activerecord.models.course"), instructor_courses_path(instructor)
    else
      link_to t("activerecord.models.course"), nil, class: "disabled"
    end
  end

  private

  def link_to_schools
    link_to t("activerecord.models.course"), schools_path
  end

  def link_to_courses studio, data: Date.today
    link_to t("activerecord.models.course"), courses_path(studio_id: studio.id, date: date.strftime("%Y%m%d"))
  end

  def link_to_course course
    link_to course.decorate.name, course_path(course)
  end

end

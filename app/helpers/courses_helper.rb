module CoursesHelper

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
        link_to text, course_members_path(course, status: '1')
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

end

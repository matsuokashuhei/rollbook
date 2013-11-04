module InstructorsHelper

  # パン屑
  def list_item_to_instructors(active: false)
    text = t("activerecord.models.instructor")
    if active
      content_tag :li, text, class: "active"
    else
      content_tag :li, link_to_instructors
    end
  end

  def list_item_to_instructor(instructor, active: false)
    text = instructor.name
    if active
      content_tag :li, text, class: "active"
    else
      content_tag :li, link_to_instructor(instructor)
    end
  end

  # タブリンク
  def tab_to_instructor instructor, active: false
    text = t "activerecord.models.instructor"
    if active
      content_tag :li, class: "active" do
        link_to text, '#instructor', data: { toggle: "tab" }
      end
    else
      content_tag :li do
        link_to text, instructor_path(instructor)
      end
    end
  end

  def tab_to_instructors_courses instructor, active: false
    text = t "activerecord.models.course"
    if active
      content_tag :li, class: "active" do
        link_to text, '#course', data: { toggle: "tab" }
      end
    else
      content_tag :li do
        link_to text, instructor_courses_path(instructor)
      end
    end
  end

  private

  def link_to_instructors
    link_to t("activerecord.models.instructor"), instructors_path
  end

  def link_to_instructor instructor
    link_to instructor.name, instructor_path(instructor)
  end

end

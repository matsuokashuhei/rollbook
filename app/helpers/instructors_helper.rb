module InstructorsHelper

  def list_item_to_instructors(active: false)
    text = t("activerecord.models.instructor")
    if active
      content_tag :li, text, class: "active"
    else
      content_tag :li, instructors_link
    end
  end

  def list_item_to_instructor(instructor, active: false)
    text = instructor.name
    if active
      content_tag :li, text, class: "active"
    else
      content_tag :li, instructor_link(instructor)
    end
  end

  def instructors_link
    link_to t("activerecord.models.instructor"), instructors_path
  end
  def instructor_link(instructor)
    link_to instructor.name, instructor_path(instructor)
  end
end

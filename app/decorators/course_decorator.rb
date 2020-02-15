class CourseDecorator < ApplicationDecorator
  delegate_all

  def list_item(active:)
    if active
      h.link_to h.t('activerecord.models.course'), '#course', data: { toggle: 'tab' }
    else
      link
    end
  end

  def link(text: h.t('activerecord.models.course'))
    h.link_to text, h.course_path(model)
  end

  def members_link(text: h.t('activerecord.models.member'))
    h.link_to text, h.course_members_path(course, status: '1')
  end

  def lessons_link(text: h.t('activerecord.models.lesson'))
    h.link_to text, h.course_lessons_path(course)
  end

end

class InstructorDecorator < ApplicationDecorator
  delegate_all

  def list_item(active:)
    if active
      h.link_to h.t('activerecord.models.instructor'), '#instructor', data: { toggle: 'tab' }
    else
      link
    end
  end

  def link(text: h.t('activerecord.models.instructor'))
    h.link_to text, h.instructor_path(model)
  end

  def courses_link(text: h.t('activerecord.models.course'))
    h.link_to text, h.instructor_courses_path(model, status: '1')
  end

  def name
    if model.kana.present?
      h.content_tag(:small, model.kana) + h.tag(:br) + model.name
    else
      model.name
    end
  end

  def team
    "(#{model.team})" if model.team.present?
  end

end

class InstructorDecorator < ApplicationDecorator
  delegate_all

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

  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  #   def created_at
  #     helpers.content_tag :span, class: 'time' do
  #       object.created_at.strftime("%a %m/%d/%y")
  #     end
  #   end

end

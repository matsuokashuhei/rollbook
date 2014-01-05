class InstructorDecorator < ApplicationDecorator
  delegate_all

  def name
=begin
    text =  "<ul class='list-unstyled' style='margin-top: 1px; margin-bottom: 1px;'>"
    text += "<li>"
    if model.team.present?
      text += h.content_tag :h6, style: "margin-top: 0px; margin-bottom: 0px;" do
        "#{model.team}"
      end
    text += "</li>"
    end
    text += "<li>"
    text += h.content_tag :h3, style: "margin-top: 0px; margin-bottom: 0px;" do
      "#{model.name}"
    end
    text += "</li>"
    text += "</ul>"
    text.html_safe
=end
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

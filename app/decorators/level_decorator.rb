class LevelDecorator < ApplicationDecorator
  delegate_all

  def name
    color = ""
    case model.name
    when "初級"
      color = "silver"
    when "中級"
      color = "gold"
    else
      color = "bronze"
    end
    h.content_tag(:span, class: "badge", style: "background-color: #{color};") do
      model.name
    end
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

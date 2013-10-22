class LevelDecorator < ApplicationDecorator
  delegate_all

  def name
    color = "#A4A4A4"
    case model.name
    when "幼児"
      color = "#D0FA58"
    when "小学生"
      color = "#F4FA58"
    when "小学生中級"
      color = "#F4FA58"
    when "基礎"
      color = "#F7D358"
    when "初級"
      color = "#FAAC58"
    when "中級"
      color = "#FA5858"
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

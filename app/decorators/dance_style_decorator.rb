class DanceStyleDecorator < ApplicationDecorator
  delegate_all

  BLUE = "#3069ff"
  PINK = "#f01e8a"
  GREEN = "#78be09"
  def name
    color = ""
    case model.name
    when "HIPHOP"
      color = BLUE
    when "BasicHIPHOP"
      color = BLUE
    when "GirlsHIPHOP"
      color = PINK
    when "KidsHIPHOP"
      color = GREEN
    when "LOCKIN'"
      color = "#fd3131"
    when "REGGAE"
      color = "ffcc00"
    when "JAZZ"
      color = "ffcc00"
    else
      color = "gray"
    end
    h.content_tag(:span, class: "label", style: "background-color: #{color};") do
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

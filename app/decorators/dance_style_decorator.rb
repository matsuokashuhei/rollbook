class DanceStyleDecorator < ApplicationDecorator
  delegate_all

  BLUE = "#3069ff"
  PINK = "#f01e8a"
  GREEN = "#78be09"
  ORAGE = "ffcc00"
  RED = "#fd3131"
  YELLOW = "ffcc00"
  def name
    color = ""
    case model.name
    when "HIPHOP"
      color = BLUE
    when "BasicHIPHOP"
      color = BLUE
    when "StyleHIPHOP"
      color = BLUE
    when "GirlsHIPHOP"
      color = PINK
    when "KidsHIPHOP"
      color = GREEN
    when "Jr.HIPHOP"
      color = GREEN
    when "Jr.ADVANCE"
      color = GREEN
    when "LOCKIN'"
      color = RED
    when "BREAKIN'"
      color = RED
    when "HOUSE"
      color = RED
    when "POP"
      color = RED
    when "PUNKING"
      color = RED
    when "ANIMATION"
      color = RED
    when "REGGAE"
      color = YELLOW
    when "ReggaeHIPHOP"
      color = YELLOW
    when "EXERCISE"
      color = YELLOW
    when "JAZZ"
      color = ORANGE
    when "JazzHIPHOP"
      color = ORANGE
    when "R&B"
      color = ORANGE
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

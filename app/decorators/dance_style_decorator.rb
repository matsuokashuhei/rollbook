class DanceStyleDecorator < ApplicationDecorator
  delegate_all

  COLORS = {
    blue: "#3069ff",
    pink: "#f01e8a",
    green: "#78be09",
    orange: "#ffcc00",
    red: "#fd3131",
    yellow: "ffcc00",
  }

  def name
    color = ""
    case model.name
    when "HIPHOP"
      color = COLORS[:blue]
    when "BasicHIPHOP"
      color = COLORS[:blue]
    when "StyleHIPHOP"
      color = COLORS[:blue]
    when "GirlsHIPHOP"
      color = COLORS[:pink]
    when "KidsHIPHOP"
      color = COLORS[:green]
    when "Jr.HIPHOP"
      color = COLORS[:green]
    when "Jr.ADVANCE"
      color = COLORS[:green]
    when "LOCKIN'"
      color = COLORS[:red]
    when "BREAKIN'"
      color = COLORS[:red]
    when "HOUSE"
      color = COLORS[:red]
    when "POP"
      color = COLORS[:red]
    when "PUNKING"
      color = COLORS[:red]
    when "ANIMATION"
      color = COLORS[:red]
    when "REGGAE"
      color = COLORS[:yellow]
    when "ReggaeHIPHOP"
      color = COLORS[:yellow]
    when "EXERCISE"
      color = COLORS[:yellow]
    when "JAZZ"
      color = COLORS[:orange]
    when "JazzHIPHOP"
      color = COLORS[:orange]
    when "R&B"
      color = COLORS[:orange]
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

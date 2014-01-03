class TimetableDecorator < ApplicationDecorator
  delegate_all

  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  #   def created_at
  #     helpers.content_tag :span, class: 'time' do
  #       object.created_at.strftime("%a %m/%d/%y")
  #     end
  #   end

  def weekday
    case model.weekday
    when 1
      "月"
    when 2
      "火"
    when 3
      "水"
    when 4
      "木"
    when 5
      "金"
    when 6
      "土"
    when 7
      "日"
    end
  end

end

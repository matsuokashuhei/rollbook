class CourseDecorator < ApplicationDecorator
  delegate_all
  decorates_association :dance_style
  decorates_association :level

  def name
    "#{model.dance_style.name}#{model.level.name}　#{model.instructor.name}"
  end

  def weekday_ja(cwday)
    { 1 => "月", 2 => "火", 3 => "水", 4 => "木", 5 => "金", 6 => "土", 7 => "日" }[cwday]
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

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

  def name_new
    timetable = model.timetable
    time_slot = timetable.time_slot
    studio = timetable.studio
    school = studio.school
    text =  "<ul class='list-unstyled' style='margin-top: 1px; margin-bottom: 1px;'>"
    text += "<li>"
    text += h.content_tag :h6, style: "margin-top: 0px; margin-bottom: 0px;" do
      "#{school.name}#{studio.name}　#{weekday_ja(timetable.weekday)}曜#{time_slot.start_time}〜"
    end
    text += "</li>"
    text += "<li>"
    text += h.content_tag :h3, style: "margin-top: 0px; margin-bottom: 0px;" do
      "#{model.dance_style.name}#{model.level.name}"
    end
    text += "</li>"
    text += "</ul>"
    text.html_safe
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

class LessonDecorator < ApplicationDecorator
  delegate_all

  def status
    h.content_tag(:h3, style: "margin: 0px; line-height: 0;") do
      case model.status
      when Lesson::STATUSES[:NONE]
        h.content_tag(:span, "未登録", class: "label label-default")
      when Lesson::STATUSES[:IN_PROCESS]
        h.content_tag(:span, "登録中", class: "label label-info")
      when Lesson::STATUSES[:FINISHED]
        h.content_tag(:span, "確定済", class: "label label-success")
      end
    end
  end

  def number_of_members
    h.content_tag(:div, class: "pull-right") do
      "#{model.course.members_courses.active(model.date).count}人"
    end
  end

  def present_rolls
    return if model.status == Lesson::STATUSES[:NONE]
    h.content_tag(:div, class: "pull-right") do
      "#{model.rolls.presences.count}人"
    end
  end

  def absent_rolls
    return if model.status == Lesson::STATUSES[:NONE]
    h.content_tag(:div, class: "pull-right") do
      "#{model.rolls.absences.count}人"
    end
  end

  def other_rolls
    return if model.status == Lesson::STATUSES[:NONE]
    other_statuses = ["0", "3", "4", "5", "6", ]
    h.content_tag(:div, class: "pull-right") do
      "#{model.rolls.where(status: other_statuses).count}人"
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

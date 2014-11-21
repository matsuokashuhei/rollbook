class LessonDecorator < ApplicationDecorator
  delegate_all

  def status
    h.content_tag(:h4, style: "margin: 0px; line-height: 0;") do
      case model.status
      when Lesson::STATUS[:UNFIXED]
        h.content_tag(:span, "", class: "label label-default")
      when Lesson::STATUS[:ON_SCHEDULE]
        h.content_tag(:span, "", class: "label label-success")
      when Lesson::STATUS[:CANCEL_BY_INSTRUCTOR]
        h.link_to '#', data: { toggle: "tooltip", "original-title" => "インストラクターの欠勤" } do
          h.content_tag(:span, "休　講", class: "label label-danger")
        end
      when Lesson::STATUS[:CANCEL_BY_OTHERS]
        h.link_to '#', data: { toggle: "tooltip", "original-title" => "自然災害などその他の理由" } do
          h.content_tag(:span, "休　講", class: "label label-warning")
        end
      end
    end
  end

  def rolls_status
    h.content_tag(:h4, style: "margin: 0px; line-height: 0;") do
      case model.rolls_status
      when Lesson::ROLLS_STATUS[:NONE]
        h.content_tag(:span, "未登録", class: "label label-default")
      when Lesson::ROLLS_STATUS[:IN_PROCESS]
        h.content_tag(:span, "登録中", class: "label label-info")
      when Lesson::ROLLS_STATUS[:FINISHED]
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
    return if model.rolls_status == Lesson::ROLLS_STATUS[:NONE]
    h.content_tag(:div, class: "pull-right") do
      "#{model.rolls.presences.count}人"
    end
  end

  def absent_rolls
    return if model.rolls_status == Lesson::ROLLS_STATUS[:NONE]
    h.content_tag(:div, class: "pull-right") do
      "#{model.rolls.absences.count}人"
    end
  end

  def substitute_rolls
    return if model.rolls_status == Lesson::ROLLS_STATUS[:NONE]
    h.content_tag(:div, class: "pull-right") do
      "#{model.rolls.substitutes.count}人"
    end
  end

  def recess_rolls
    return if model.rolls_status == Lesson::ROLLS_STATUS[:NONE]
    h.content_tag(:div, class: "pull-right") do
      "#{model.rolls.recesses.count}人"
    end
  end

  def other_rolls
    return if model.rolls_status == Lesson::ROLLS_STATUS[:NONE]
    other_statuses = ["0", "3", "4", "5", "6", ]
    h.content_tag(:div, class: "pull-right") do
      "#{model.rolls.where(status: other_statuses).count}人"
    end
  end

  def cancellation_penalty_detail
    return '' unless model.status == Lesson::STATUS[:CANCEL_BY_INSTRUCTOR]
    members_courses = model.course.members_courses.active(date).select {|members_course| members_course.in_recess?(date.strftime("%Y%m")) == false }
    weekly_fee = (Rollbook::Money.include_consumption_tax(course.monthly_fee) * 0.25).to_i
    "#{weekly_fee}円 X #{members_courses.count}人"
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

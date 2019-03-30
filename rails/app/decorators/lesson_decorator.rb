class LessonDecorator < ApplicationDecorator
  delegate_all

  def status
    return if model.new_record?
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
    return if model.new_record?
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

  def attendances_count
    return if model.rolls_status == Lesson::ROLLS_STATUS[:NONE]
    number_of_people(model.rolls.attendances.count)
  end

  def absentees_count
    return if model.rolls_status == Lesson::ROLLS_STATUS[:NONE]
    number_of_people(model.rolls.absences.count)
  end

  def substitutes_count
    return if model.rolls_status == Lesson::ROLLS_STATUS[:NONE]
    number_of_people(model.rolls.substitutes.count)
  end

  def recesses_count
    return if model.rolls_status == Lesson::ROLLS_STATUS[:NONE]
    number_of_people(model.rolls.recesses.count)
  end

  def other_rolls
    return if model.rolls_status == Lesson::ROLLS_STATUS[:NONE]
    other_statuses = ["0", "3", "4", "5", "6", ]
    h.content_tag(:div, class: "pull-right") do
      "#{model.rolls.where(status: other_statuses).count}人"
    end
  end

  # レッスンのキャンセル料の内訳を出す。
  def cancellation_fee_detail
    return '' unless model.status == Lesson::STATUS[:CANCEL_BY_INSTRUCTOR]
    members_courses = model.course.members_courses.active(date).select {|members_course| members_course.in_recess?(date.strftime("%Y%m")) == false }
    cancellation_fee = (Rollbook::Money.include_consumption_tax(course.monthly_fee) * 0.25).to_i
    "#{cancellation_fee}円 X #{members_courses.count}人"
  end

  # 先週のレッスンのリンクを返す。
  def prev_lesson
    one_week_before = date - 7.day
    lesson = other_day_lesson(date: one_week_before)
    h.link_to(h.lesson_rolls_path(lesson), class: 'btn btn-link pull-left') do
      h.fa_icon('caret-left', text: '先週')
    end if lesson.present?
  end
  
  # 翌週のレッスンのリンクを返す。
  def next_lesson
    one_week_after = date + 7.day
    lesson = other_day_lesson(date: one_week_after)
    h.link_to(h.lesson_rolls_path(lesson), class: 'btn btn-link pull-right') do
      h.fa_icon('caret-right', text: '翌週', right: true)
    end if lesson.present?
  end

  private
  
    def other_day_lesson(date: date)
      Lesson.find_by(course_id: model.course_id, date: date)
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

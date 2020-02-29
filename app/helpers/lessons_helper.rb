module LessonsHelper

  def link_to_prev_months_lessons month
    end_of_prev_month = Rollbook::Util::Month.beginning_of_month(month) - 1.day
    link_to lessons_path(month: end_of_prev_month.strftime('%Y%m')), class: "btn btn-link pull-left" do
      fa_icon("caret-left", text: end_of_prev_month.strftime('%Y年%m月'))
    end
  end

  def link_to_next_months_lessons month
    beginning_of_next_month = Rollbook::Util::Month.end_of_month(month) + 1.day
    link_to lessons_path(month: beginning_of_next_month.strftime('%Y%m')), class: "btn btn-link pull-right" do
      fa_icon('caret-right', text: beginning_of_next_month.strftime('%Y年%m月'), right: true)
    end
  end

  def link_to_day_before_lessons date, school_id
    if Holiday.workday?(date.yesterday)
      link_to lessons_path(date: date.yesterday.to_s(:number), school_id: school_id), class: "btn btn-link pull-left" do
        fa_icon("caret-left", text: date.yesterday.strftime("%m月%d日"))
      end
    end
  end

  def link_to_day_after_lessons date, school_id
    if Holiday.workday?(date.tomorrow)
      link_to lessons_path(date: date.tomorrow.to_s(:number), school_id: school_id), class: "btn btn-link pull-right" do
        fa_icon('caret-right', text: date.tomorrow.strftime('%m月%d日'), right: true)
      end
    end
  end

end

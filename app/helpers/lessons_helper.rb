module LessonsHelper

  def link_to_prev_months_lessons month
    prev_month = (month.concat("01").to_date - 1.day).strftime("%Y%m")
    text = prev_month[0..3].concat("年").concat(prev_month[4..5]).concat("月")
    link_to lessons_path(month: prev_month), class: "btn btn-link pull-left" do
      fa_icon "caret-left", text: text
    end
  end

  def link_to_next_months_lessons month
    next_month = (month.concat("01").to_date + 1.month).strftime("%Y%m")
    text = next_month[0..3].concat("年").concat(next_month[4..5]).concat("月").concat(" ")
    link_to lessons_path(month: next_month), class: "btn btn-link pull-right" do
      (text.concat(fa_icon("caret-right"))).html_safe
    end
  end

  def link_to_yesterdays_lessons date, school_id
    yesterday = date - 1.day
    unless Holiday.exists? date: yesterday
      link_to lessons_path(date: yesterday.to_s(:number), school_id: school_id), class: "btn btn-link pull-left" do
        fa_icon "caret-left", text: yesterday.strftime("%m月%d日")
      end
    end
  end

  def link_to_tomorrows_lessons date, school_id
    tomorrow = date + 1.day
    unless Holiday.exists? date: tomorrow
      link_to lessons_path(date: tomorrow.to_s(:number), school_id: school_id), class: "btn btn-link pull-right" do
        tomorrow.strftime("%m月%d日 ").concat(fa_icon("caret-right")).html_safe
      end
    end
  end

  def link_to_prev_lesson lesson
    if lesson
      text = "先週"
      link_to lesson_rolls_path(lesson), class: "btn btn-link pull-left" do
        fa_icon "caret-left", text: text
      end
    end
  end

  def link_to_next_lesson lesson
    if lesson
      text = "翌週 "
      link_to lesson_rolls_path(lesson), class: "btn btn-link pull-right" do
        (text.concat(fa_icon("caret-right"))).html_safe
      end
    end
  end

end

module LessonsHelper

  def list_item_to_lessons active: false
    text = t("activerecord.models.lesson")
    content_tag :li do
      link_to text, lessons_path
    end
  end

  def list_item_to_lessons_of_month month, active: false
    text = month.concat("01").to_date.strftime("%Y年%m月")
    if active
      content_tag :li, text, class: "active"
    else
      content_tag :li do
        link_to text, lessons_path(month: month)
      end
    end
  end

  def list_item_to_lessons_of_day date, active: false
    text = date.strftime("%d日")
    if active
      content_tag :li, text, class: "active"
    else
      content_tag :li do
        link_to text, lessons_path(date: date)
      end
    end
  end

  def link_to_lessons month: nil
    if month.nil?
      link_to t("activerecord.models.lesson"), lessons_path
    else
      text = month.concat("01").to_date.strftime("%Y年%m月")
      link_to text, lessons_path(month: month)
    end
  end

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

  def link_to_yesterdays_lessons date
    yesterday = date - 1.day
    if yesterday.day < 29
      link_to lessons_path(date: yesterday.strftime("%Y%m%d")), class: "btn btn-link pull-left" do
        fa_icon "caret-left", text: yesterday.strftime("%Y年%m月%d日")
      end
    end
  end

  def link_to_tomorrows_lessons date
    tomorrow = date + 1.day
    if tomorrow.day < 29
      link_to lessons_path(date: tomorrow.strftime("%Y%m%d")), class: "btn btn-link pull-right" do
        tomorrow.strftime("%Y年%m月%d日 ").concat(fa_icon("caret-right")).html_safe
      end
    end
  end

  def button_to_fix lesson
    text = t "views.buttons.fix"
    if lesson.fix?
      link_to '#lesson', class: "btn btn-primary pull-right", data: { toggle: "modal" } do
        fa_icon "lock", text: text
      end
    else
      link_to nil, class: "btn btn-primary pull-right disabled" do
        fa_icon "lock", text: text
      end
    end
  end

  #def course_lessons_link(course, disable: false)
  #  unless disable
  #    link_to t("activerecord.models.lesson"), lessons_path
  #  else
  #    link_to t("activerecord.models.lesson"), nil, class: "disabled"
  #  end
  #end

  private

end

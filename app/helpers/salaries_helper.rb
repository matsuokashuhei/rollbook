module SalariesHelper

  def list_item_to_salaries active: false
    text = "給料"
    month = (Date.today - 1.month).strftime('%Y%m')
    content_tag :li do
      link_to text, salaries_path(month: month)
    end
  end

  def list_item_to_salaries_of_month month, active: false
    text = (month + "01").to_date.strftime("%Y年%m月")
    if active
      content_tag :li, text, class: "active"
    else
      content_tag :li do
        link_to text, salaries_path(month: month)
      end
    end
  end

  def link_to_prev_months_salaries month
    prev_month = ((month + "01").to_date - 1.day).strftime("%Y%m")
    text = prev_month[0..3].concat("年").concat(prev_month[4..5]).concat("月")
    link_to salaries_path(month: prev_month), class: "btn btn-link pull-left" do
      fa_icon "caret-left", text: text
    end
  end

  def link_to_next_months_salaries month
    next_month = ((month + "01").to_date + 1.month).strftime("%Y%m")
    text = next_month[0..3].concat("年").concat(next_month[4..5]).concat("月").concat(" ")
    link_to salaries_path(month: next_month), class: "btn btn-link pull-right" do
      (text.concat(fa_icon("caret-right"))).html_safe
    end
  end

  def list_item_to_salary month, instructor, active: false
    text = instructor.name
    if active
      content_tag :li, text, class: "active"
    else
      content_tag :li do
        link_to text, salary_path(month: month, instructor_id: instructor.id)
      end
    end
  end

  def label_for_recess
    content_tag(:h4, style: "margin: 0px; line-height: 0;") do
      content_tag :span, "休　会", class: "label label-default"
    end
  end

  def label_for_attend
    content_tag(:h4, style: "margin: 0px; line-height: 0;") do
      content_tag :span, "受　講", class: "label label-info"
    end
  end

  def label_for_new start_week_of_month
    content_tag(:h4, style: "margin: 0px; line-height: 0;") do
      content_tag :span, "#{start_week_of_month}週入会", class: "label label-success"
    end
  end

  def link_to_prev_months_salary month, instructor
    beginning_of_month = (month + "01").to_date
    end_of_prev_month = beginning_of_month - 1.day
    text = end_of_prev_month.strftime("%Y年%m月")
    if instructor.courses.active(end_of_prev_month).count > 0
      link_to salary_path(month: end_of_prev_month.strftime("%Y%m"), instructor_id: instructor.id), class: "btn btn-link pull-left" do
        fa_icon "caret-left", text: text
      end
    else
      link_to nil, class: "btn btn-link pull-left disabled" do
        fa_icon "caret-left", text: text
      end
    end
  end

  def link_to_next_months_salary month, instructor
    end_of_month = (month + "01").to_date.end_of_month
    begining_of_next_month = end_of_month + 1.day
    text = begining_of_next_month.strftime("%Y年%m月 ")
    if instructor.courses.active(begining_of_next_month).count > 0
      link_to salary_path(month: begining_of_next_month.strftime("%Y%m"), instructor_id: instructor.id), class: "btn btn-link pull-right" do
        text.concat(fa_icon("caret-right")).html_safe
      end
    else
      link_to nil, class: "btn btn-link pull-right disabled" do
        fa_icon "caret-left", text: text
      end
    end
  end
end

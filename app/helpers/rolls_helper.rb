module RollsHelper
  STATUS = {
    "0" => { "name" => "未定", "label" => "label-default", "button" => "btn-default" },
    "1" => { "name" => "出席", "label" => "label-success", "button" => "btn-success" },
    "2" => { "name" => "欠席", "label" => "label-danger", "button" => "btn-danger" },
    "3" => { "name" => "欠席", "label" => "label-warning", "button" => "btn-warning" },
    "4" => { "name" => "振替", "label" => "label-info", "button" => "btn-info" },
  }

  def status_name(status)
    STATUS[status]["name"]
  end
  def status_label(status)
    STATUS[status]["label"]
  end

  def status_button(status)
    STATUS[status]["button"]
  end

  def status_html(status)
    ("<h3 style=\"margin: 0px; line-height: 0;\"><span class=\"label %s\">%s</span></h3>" % [status_label(status), status_name(status)]).html_safe
  end

  def roll_status_html(status)
    status_html(status)
  end

end

module RollsHelper
  ROLL_STATUS = {
    "0" => { "name" => "未定", "label" => "label-default", "button" => "btn-default" },
    "1" => { "name" => "出席", "label" => "label-success", "button" => "btn-success" },
    "2" => { "name" => "欠席", "label" => "label-danger", "button" => "btn-danger" },
    "3" => { "name" => "欠席", "label" => "label-warning", "button" => "btn-warning" },
    "4" => { "name" => "振替", "label" => "label-info", "button" => "btn-info" },
  }

  def roll_status_name(status)
    ROLL_STATUS[status]["name"]
  end
  def roll_status_label(status)
    ROLL_STATUS[status]["label"]
  end

  def roll_status_button(status)
    ROLL_STATUS[status]["button"]
  end

  def display_roll_status(status)
    ("<h3 style=\"margin: 0px; line-height: 0;\"><span class=\"label %s\">%s</span></h3>" % [roll_status_label(status), roll_status_name(status)]).html_safe
  end

end

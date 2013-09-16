module LessonsHelper
  STATUS = {
    "0" => { "name" => "未登録", "label" => "label-default", },
    "1" => { "name" => "登録中", "label" => "label-info", },
    "2" => { "name" => "確定済", "label" => "label-success", },
  }

  def status_name(status)
    STATUS[status]["name"]
  end

  def status_label(status)
    STATUS[status]["label"]
  end

  def status_html(status)
    ("<h3 style=\"margin: 0px; line-height: 0;\"><span class=\"label %s\">%s</span></h3>" % [status_label(status), status_name(status)]).html_safe
  end
end

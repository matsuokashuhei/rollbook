module LessonsHelper

  def lessons_link
    link_to t("activerecord.models.lesson"), lessons_path
  end

  LESSON_STATUS = {
    "0" => { "name" => "未登録", "label" => "label-default", },
    "1" => { "name" => "登録中", "label" => "label-info", },
    "2" => { "name" => "確定済", "label" => "label-success", },
  }

  def lesson_status_name(status)
    LESSON_STATUS[status]["name"]
  end

  def lesson_status_label(status)
    LESSON_STATUS[status]["label"]
  end

  def display_lesson_status(status)
    ("<h3 style=\"margin: 0px; line-height: 0;\"><span class=\"label %s\">%s</span></h3>" % [lesson_status_label(status), lesson_status_name(status)]).html_safe
  end

end

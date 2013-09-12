module LessonsHelper
  def status_ja(status)
    { "0" => "未登録",
      "1" => "登録中",
      "2" => "確定済",
    }[status]
  end
  def status_label(status)
    labels = { "0" => "label-default",
               "1" => "label-info",
               "2" => "label-success", }
    "<h4><span class=\"label #{labels[status]}\">#{status_ja(status)}</span></h4>".html_safe
  end
end

module RollsHelper
  STATUS_JA = {
    "0" => "未定",
    "1" => "出席",
    "2" => "欠席",
    "3" => "欠席",
    "4" => "振替",
  }
  STATUS_LABELS = {
    "0" => "label-default",
    "1" => "label-success",
    "2" => "label-danger",
    "3" => "label-warning",
    "4" => "label-info"
  }
  STATUS_BUTTONS = {
    "0" => "btn-default",
    "1" => "btn-success",
    "2" => "btn-danger",
    "3" => "btn-warning",
    "4" => "btn-info"
  }

  def status_ja(status)
    STATUS_JA[status]
  end

  def status_button(status)
    STATUS_BUTTONS[status]
  end

  def status_label(status)
    "<h4><span class=\"label #{STATUS_LABELS[status]}\">#{STATUS_JA[status]}</span></h4>".html_safe
  end

end

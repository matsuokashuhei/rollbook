module RollsHelper

  def member_rolls_link(member, disabled: false)
    unless disabled
      link_to t("activerecord.models.lesson"), member_rolls_path(member)
    else
      link_to t("activerecord.models.lesson"), nil, class: "disabled"
    end
  end

  ROLL_STATUS = {
    "0" => { "name" => "未定", "label" => "label-default", "button" => "btn-default" },
    "1" => { "name" => "出席", "label" => "label-success", "button" => "btn-success" },
    "2" => { "name" => "欠席", "label" => "label-danger", "button" => "btn-danger" },
    "3" => { "name" => "欠席", "label" => "label-warning", "button" => "btn-warning" },
    "4" => { "name" => "振替", "label" => "label-info", "button" => "btn-info" },
    "5" => { "name" => "休会", "label" => "label-primary", "button" => "btn-primary" },
    "6" => { "name" => "体験", "label" => "label-success", "button" => "btn-success" },
    "9" => { "name" => "取消", "label" => "label-default", "button" => "btn-default" },
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

end

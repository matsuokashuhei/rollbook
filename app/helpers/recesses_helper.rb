module RecessesHelper

  def recesses_link(member, disabled: false)
    unless disabled
      link_to t("activerecord.models.recess"), member_recesses_path(member)
    else
      link_to t("activerecord.models.recess"), nil, class: "disabled"
    end
  end

  RECESS_STATUS = {
    "0" => "未",
    "1" => "済",
    "2" => "不要",
  }

  def display_recess_status(status)
    RECESS_STATUS[status]
  end

end

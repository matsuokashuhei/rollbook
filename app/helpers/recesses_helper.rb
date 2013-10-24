module RecessesHelper

  RECESS_STATUSES = [
    ["未返金", "0"],
    ["返金済", "1"],
    ["残不", "2"],
  ]

  def recesses_link(member, disabled: false)
    unless disabled
      link_to t("activerecord.models.recess"), member_recesses_path(member)
    else
      link_to t("activerecord.models.recess"), nil, class: "disabled"
    end
  end

end

module ReceiptsHelper

  def member_receipts_link(member, disabled: false)
    unless disabled
      link_to t("activerecord.models.receipt"), member_receipts_path(member)
    else
      link_to t("activerecord.models.receipt"), nil, class: "disabled"
    end
  end

end

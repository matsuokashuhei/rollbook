module ReceiptsHelper

  # パン屑
  def list_item_to_receipts tuition, active: false
    #text = t "activerecord.models.receipt"
    text = tuition.month_ja
    if active
      content_tag :li, text, class: "active"
    else
      content_tag :li, link_to_receipts(tuition)
    end
  end

  def list_item_to_receipt tuition, receipt, active: false
    text = receipt.member.full_name
    if active
      content_tag :li, text, class: "active"
    else
      content_tag :li, link_to_receipt(tuition, receipt)
    end
  end

  # タブリンク
  def tab_to_members_receipts(member, active: false)
    text = t("activerecord.models.receipt")
    if active
      content_tag :li, class: "active" do
        link_to text, '#members_receipts', data: { toggle: "tab" }
      end
    else
      content_tag :li, link_to_members_receipts(member)
    end
  end

  private

  def link_to_members_receipts(member)
    link_to t("activerecord.models.receipt"), member_receipts_path(member)
  end

  def link_to_receipts tuition
    link_to tuition.month_ja, tuition_receipts_path(tuition)
  end

  def link_to_receipt tuition, receipt
    link_to receipt.member.full_name, tuition_receipt_path(tuition, receipt)
  end

end

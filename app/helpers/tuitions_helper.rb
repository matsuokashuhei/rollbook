module TuitionsHelper

  # パン屑用
  def list_item_to_tuitions(payment_method: "DEBIT", active: false)
    text = t("activerecord.models.tuition")
    if active
      content_tag :li, text, class: "active"
    else
      content_tag :li, link_to_tuitions(payment_method)
    end
  end

  private
  def link_to_tuitions(payment_method)
    link_to t("activerecord.models.tuition"), tuitions_path(paymemt_method: payment_method)
  end
end

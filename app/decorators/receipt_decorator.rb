class ReceiptDecorator < ApplicationDecorator
  decorates_association :member
  delegate_all

  def method
    if model.method == Receipt::METHODS[:DEBIT]
      "振込"
    else
      "現金"
    end
  end

  def status
    label = "<h3 style=\"margin: 8px; line-height: 0;\">"
    case model.status
    when Receipt::STATUSES[:PAID]
      label << "<span class=\"label label-success\">支払い済</span>"
    when Receipt::STATUSES[:UNPAID]
      label << "<span class=\"label label-danger\">未払い</span>"
    end
    label << "</h3>"
    label.html_safe
  end

end

class ReceiptDecorator < ApplicationDecorator
  decorates_association :member
  delegate_all

  def method
    #[["引落", Receipt::METHODS[:DEBIT]], ["現金", Receipt::METHODS[:PAID_CASH]], ["振済", Receipt::METHODS[:PAID_BANK]], ["相殺", Receipt::METHODS[:OFFSET]]]
    case model.method
    when Receipt::METHODS[:DEBIT]
      "引落"
    when Receipt::METHODS[:PAID_CASH]
      "現金"
    when Receipt::METHODS[:PAID_BANK]
      "振済"
    when Receipt::METHODS[:OFFSET]
      "相殺"
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

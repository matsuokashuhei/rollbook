class TuitionDecorator < ApplicationDecorator
  delegate_all

  def month_ja
    model.month[0..3] + "年" + model.month[5..6] + "月"
  end

  def debit_status
    label = "<h3 style=\"margin: 0px; line-height: 0;\">"
    case model.debit_status
    when Tuition::DEBIT_STATUSES[:IN_PROCESS]
      label << "<span class=\"label label-info\">仕掛中</span>"
    when Tuition::DEBIT_STATUSES[:FINISHED]
      label << "<span class=\"label label-success\">完了</span>"
    end
    label << "</h3>"
    label.html_safe
  end

  def receipt_status
    label = "<h3 style=\"margin: 0px; line-height: 0;\">"
    case model.receipt_status
    when Tuition::RECEIPT_STATUSES[:NONE]
      label << "<span class=\"label label-default\">未定</span>"
    when Tuition::RECEIPT_STATUSES[:IN_PROCESS]
      label << "<span class=\"label label-info\">仕掛中</span>"
    when Tuition::RECEIPT_STATUSES[:FINISHED]
      label << "<span class=\"label label-success\">完了</span>"
    end
    label << "</h3>"
    label.html_safe
  end

  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  #   def created_at
  #     helpers.content_tag :span, class: 'time' do
  #       object.created_at.strftime("%a %m/%d/%y")
  #     end
  #   end

end

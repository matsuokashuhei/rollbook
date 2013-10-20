class TuitionDecorator < ApplicationDecorator
  delegate_all

  def month_ja
    model.month[0..3] + "年" + model.month[5..6] + "月"
  end

  def debit_status
    h.content_tag(:h3, style: "margin: 0px; line-height: 0;") do
      case model.debit_status
      when Tuition::DEBIT_STATUSES[:IN_PROCESS]
        h.content_tag(:span, "リストアップ中", class: "label label-warning")
      when Tuition::DEBIT_STATUSES[:FINISHED]
        h.content_tag(:span, "リストアップ終了", class: "label label-success")
      end
    end
  end

  def receipt_status
    h.content_tag(:h3, style: "margin: 0px; line-height: 0;") do
      case model.receipt_status
      when Tuition::RECEIPT_STATUSES[:IN_PROCESS]
        h.content_tag(:span, "受取中", class: "label label-warning")
      when Tuition::RECEIPT_STATUSES[:FINISHED]
        h.content_tag(:span, "受取終了", class: "label label-success")
      end
    end
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

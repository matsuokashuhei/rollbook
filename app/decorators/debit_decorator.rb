class DebitDecorator < ApplicationDecorator
  delegate_all
  decorates_association :bank_account

  def status
    h.content_tag(:h3, style: "margin: 0px; line-height: 0;") do
      case model.status
      when Debit::STATUSES[:SUCCESS]
        h.content_tag(:span, "引　落", class: "label label-success")
      when Debit::STATUSES[:FAILURE]
        h.content_tag(:span, "残　不", class: "label label-danger")
      when Debit::STATUSES[:OTHERS]
        h.content_tag(:span, "その他", class: "label label-default")
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

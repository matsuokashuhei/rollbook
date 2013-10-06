class DebitDecorator < ApplicationDecorator
  delegate_all

  def status_name
    { "1" => "完了",
      "2" => "残高不足", }[model.status]
  end

  def status_label
    label = "<h3 style=\"margin: 0px; line-height: 0;\">"
    case model.status
    when Debit::STATUSES[:SUCCESS]
      label << "<span class=\"label label-success\">完了</span>"
    when Debit::STATUSES[:FAILURE]
      label << "<span class=\"label label-danger\">不能</span>"
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

class TuitionDecorator < ApplicationDecorator
  delegate_all

  def status
    label = "<h3 style=\"margin: 0px; line-height: 0;\">"
    case model.status
    when Tuition::STATUSES[:DEBIT_IN_PROCESS]
      label << "<span class=\"label label-success\">口座振替　確認中</span>"
    when Tuition::STATUSES[:DEBIT_FINISHED]
      label << "<span class=\"label label-danger\">口座振替　完了</span>"
    when Tuition::STATUSES[:ALL_FINISHED]
      label << "<span class=\"label label-danger\">完了</span>"
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

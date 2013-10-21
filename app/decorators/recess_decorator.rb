class RecessDecorator < ApplicationDecorator
  delegate_all

  def status
    h.content_tag(:h3, style: "margin: 0px; line-height: 0:") do
      case model.status
      when Recess::STATUSES[:UNPAID]
        h.content_tag(:span, "未", class: "label label-default")
      when Recess::STATUSES[:PAID]
        h.content_tag(:span, "済", class: "label label-success")
      when Recess::STATUSES[:NONE]
        h.content_tag(:span, "残不", class: "label label-info")
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

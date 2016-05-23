class RollDecorator < ApplicationDecorator
  delegate_all
  decorates_association :member

  def status
    h.content_tag(:h3, style: "margin: 0px; line-height: 0;") do
      case model.status
      when "0"
        h.content_tag(:span, "未定", class: "label label-default")
      when "1"
        h.content_tag(:span, "出席", class: "label label-success")
      when "2"
        h.content_tag(:span, "欠席", class: "label label-danger")
      #when "3"
      #  h.content_tag(:span, "欠席", class: "label label-warning")
      when "4"
        h.content_tag(:span, "振替", class: "label label-warning")
      when "5"
        h.content_tag(:span, "休会", class: "label label-default", style: "background-color: gray")
      when "6"
        h.content_tag(:span, "休講", class: "label label-default", style: "background-color: silver")
      when "9"
        h.content_tag(:span, "取消", class: "label label-default")
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

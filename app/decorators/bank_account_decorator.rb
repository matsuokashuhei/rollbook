class BankAccountDecorator < ApplicationDecorator
  delegate_all

  def holder_name
    h.content_tag(:small, "#{model.holder_name_kana}") + h.tag(:br) + "#{model.holder_name}"
  end

  def status
    #h.content_tag(:h3, style: "margin: 8px; line-height: 0;") do
    h.content_tag :h3, style: "margin: 0px; line-height: 0;" do
      if model.active?
        h.content_tag(:span, "引落中", class: "label label-success")
      else
        h.content_tag(:span, "手続中", class: "label label-warning")
      end
=begin
      if model.active?
        h.content_tag(:span, "引落中", class: "label label-success")
      elsif model.begin_date.present?
        h.content_tag(:span, "引落待ち", class: "label label-info")
      elsif model.ship_date.present?
        h.content_tag(:span, "発送", class: "label label-warning")
      else
        h.content_tag(:span, "受取", class: "label label-default")
      end
=end
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

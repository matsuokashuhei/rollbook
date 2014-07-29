class BankAccountDecorator < ApplicationDecorator
  delegate_all

  def holder_name
    text =  "<ul class='list-unstyled' style='margin-top: 1px; margin-bottom: 1px;'>"
    text += "<li>"
    text += h.content_tag :h5, style: "margin-top: 0px; margin-bottom: 0px;" do
      h.content_tag :small do
        model.holder_name_kana
      end
    end
    text += "</li>"
    text += "<li>"
    text += h.content_tag :h5, style: "margin-top: 0px; margin-bottom: 0px;" do
      model.holder_name
    end
    text += "</li>"
    text += "</ul>"
    text.html_safe
    #h.content_tag(:small, "#{model.holder_name_kana}") + h.tag(:br) + "#{model.holder_name}"
  end

  def status
    #h.content_tag(:h3, style: "margin: 8px; line-height: 0;") do
    h.content_tag :h4, style: "margin: 0px; line-height: 0;" do
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

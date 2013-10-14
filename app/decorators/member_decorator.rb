class MemberDecorator < ApplicationDecorator
  delegate_all

  def name
    text = "<small>"
    text << "#{model.last_name_kana}　#{model.first_name_kana}"
    text << "</small>"
    text << "<br />"
    text << "#{model.last_name}　#{model.first_name}"
    text.html_safe
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

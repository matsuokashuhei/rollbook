class UserDecorator < ApplicationDecorator
  delegate_all

  def role
    h.content_tag(:h3, style: "margin: 0px; line-height: 0;") do
      case model.role
      when User::ROLES[:SYSTEM]
        h.content_tag(:span, "SYSTEM", class: "label label-default")
      when User::ROLES[:ADMIN]
        h.content_tag(:span, "ADMIN", class: "label label-success")
      when User::ROLES[:MANAGER]
        h.content_tag(:span, "MANAGER", class: "label label-info")
      when User::ROLES[:STAFF]
        h.content_tag(:span, "STAFF", class: "label label-warning")
      end
    end
  end

  def status
    h.content_tag(:h3, style: "margin: 0px; line-height: 0;") do
      case model.status
      when User::STATUSES[:ACTIVE]
        h.content_tag(:span, "有効", class: "label label-success")
      when User::STATUSES[:NONACTIVE]
        h.content_tag(:span, "無効", class: "label label-default")
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

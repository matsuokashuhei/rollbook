class AccessLogDecorator < ApplicationDecorator
  delegate_all

  def user_name
    model.user.name if model.user_id.present?
  end

  def operation_type
    h.content_tag :h4, class: "margin: 0px;" do
      case model.request_method
      when "GET"
        #h.t("views.buttons.show")
        h.content_tag :span, "閲覧", class: "label label-default"
      when "POST"
        h.content_tag :span, "登録", class: "label label-info"
        #h.t("views.buttons.new")
      when "PUT"
        h.content_tag :span, "変更", class: "label label-success"
        #h.t("views.buttons.edit")
      when "PATCH"
        h.content_tag :span, "変更", class: "label label-success"
      when "DELETE"
        h.content_tag :span, "削除", class: "label label-warning"
        #h.t("views.buttons.delete")
      else
        h.content_tag :span, "不明", class: "label label-danger"
        #"不明"
      end
    end
  end

  def display_path
=begin
    if model.request_method == "POST" && model.fullpath == "/users/sign_in"
      "ログイン"
    elsif model.request_method == "DELETE" && model.fullpath == "/users/sign_out"
      "ログアウト"
    else
      h.truncate(model.fullpath, length: 50)
    end
=end
    h.truncate(model.fullpath, length: 50)
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

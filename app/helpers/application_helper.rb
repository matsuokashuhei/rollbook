module ApplicationHelper

  def weekday_ja(cwday)
    { 1 => "月", 2 => "火", 3 => "水", 4 => "木", 5 => "金", 6 => "土", 7 => "日" }[cwday]
  end

  def icon_to_show text: nil
    if text.present?
      fa_icon "square-o lg", text: text
    else
      fa_icon "square-o lg"
    end
  end

  def icon_to_new text: nil
    if text.present?
      fa_icon "plus lg", text: text
    else
      fa_icon "plus lg"
    end
  end

  def icon_to_edit text:nil
    if text.present?
      fa_icon "edit lg", text: text
    else
      fa_icon "edit lg"
    end
  end

  def icon_to_destroy(text: nil)
    if text.present?
      fa_icon "trash-o lg", text: text
    else
      fa_icon "trash-o lg"
    end
  end

  def icon_to_save
    fa_icon "save lg"
  end

  def link_to_show(path, disabled: false)
    class_value = "btn btn-link"
    class_value += " disabled" if disabled
    link_to path, class: class_value, data: { toggle: "tooltip", "original-title" => t("views.buttons.show") } do
      icon_to_show
    end
  end

  def link_to_edit(path, edit: true)
    class_value = "btn btn-link"
    class_value += " disabled" unless edit
    link_to path, class: class_value, data: { toggle: "tooltip", "original-title" => t("views.buttons.edit") } do
      icon_to_edit
    end
  end

  def link_to_new(path, new: true)
    class_value = "btn btn-link"
    class_value += " disabled" unless new
    link_to path, class: class_value, data: { toggle: "tooltip", "original-title" => t("views.buttons.new") } do
      icon_to_new
    end
  end

  def link_to_destroy(id, path, destroy: true)
    if destroy
      text = link_to "##{id}", class: "btn btn-link", data: { toggle: "modal", "original-title" => t("views.buttons.delete")} do
        icon_to_destroy
      end
      text += modal_to_destroy(id, path)
    else
      link_to path, class: "btn btn-link disabled" do
        icon_to_destroy
      end
    end
  end

  def button_to_new(path, new: true, pull: nil)
    class_value = "btn btn-info"
    class_value += " pull-#{pull}" if pull.present?
    class_value += " disabled" unless new
    link_to path, class: class_value do
      icon_to_new + " " + t("views.buttons.new")
    end
  end

  def button_to_edit(path, edit: true, pull: nil)
    class_value = "btn btn-info"
    class_value += " pull-#{pull}" if pull.present?
    class_value += " disabled" unless edit
    link_to path, class: class_value do
      icon_to_edit + " " + t("views.buttons.edit")
    end
  end

  def button_to_save(save: true, pull: nil)
    class_value = "btn btn-primary"
    class_value << " pull-" + pull if pull.present?
    class_value << " disabled" unless save
    button_tag class: class_value, form: "form" do
      fa_icon "save lg", text: t("views.buttons.create")
    end
  end

  def button_to_destroy(id, path, destroy: true, pull: nil)
    class_value = "btn btn-danger"
    class_value += " pull-#{pull}" if pull.present?
    if destroy
      text = link_to "##{id}", class: class_value, data: { toggle: "modal", "original-title" => t("views.buttons.delete")} do
        icon_to_destroy(text: t("views.buttons.destroy"))
      end
      text += modal_to_destroy(id, path)
    else
      class_value += " disabled"
      link_to path, class: class_value do
        icon_to_destroy(text: t("views.buttons.destroy"))
      end
    end
  end

  def button_to_back(path, pull: nil)
    class_names = "btn btn-default"
    class_names << " pull-" + pull if pull.present?
    link_to t("views.buttons.back"), path, class: class_names
  end

  def list_item_to_new
    content_tag :li, class: "active" do
      t("views.buttons.new")
    end
  end

  def list_item_to_edit
    content_tag :li, class: "active" do
      t("views.buttons.edit")
    end
  end





  def controller?(controllers)
    controllers.each do |controller|
      return true if params[:controller] == controller
    end
    return false
  end

  private

  def modal_to_destroy(id, path)
    text  = "<div class='modal fade' id='#{id}'>".html_safe
    text += "<div class='modal-dialog'>".html_safe
    text += "<div class='modal-content'>".html_safe
    text += "<div class='modal-header'>".html_safe
    text += button_tag type: "button", class: "close", data: { dismiss: "modal" }, "aria-hidden" => true do
      "×"
    end
    text += content_tag :h4, "確認", class: "modal-title"
    text += "</div>".html_safe
    text += content_tag :div, class: "modal-body" do
      "削除してよいですか？"
    end
    text += "<div class='modal-footer'>".html_safe
    text += button_tag type: "button", class: "btn btn-default pull-left", data: { dismiss: "modal" } do
      "閉じる"
    end
    text += link_to t("views.buttons.delete"), path, method: :delete, class: "btn btn-default"
    text += "</div>".html_safe
    text += "</div>".html_safe
    text += "</div>".html_safe
    text += "</div>".html_safe
    text.html_safe
  end
end

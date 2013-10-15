module ApplicationHelper

  def weekday_ja(cwday)
    { 1 => "月", 2 => "火", 3 => "水", 4 => "木", 5 => "金", 6 => "土", 7 => "日" }[cwday]
  end

  def members_full_name(member)
    "<small>#{member.full_name_kana}</small><br />#{member.full_name}".html_safe
  end

  def display_member_name(member)
    "<small>#{member.full_name_kana}</small><br />#{member.full_name}".html_safe
  end

  def show_link_to(path, disabled: false)
    unless disabled
      link_to t("views.buttons.show"), path, class: "btn btn-default"
    else
      link_to t("views.buttons.show"), path, class: "btn btn-default disabled"
    end
  end

  def new_link_to(path, disabled: false, pull: nil)
    class_names = "btn btn-default"
    class_names << " pull-" + pull if pull.present?
    class_names << " disabled" if disabled
    link_to t("views.buttons.new"), path, class: class_names
  end

  def edit_link_to(path, disabled: false, pull: nil)
    class_names = "btn btn-default"
    class_names << " pull-" + pull if pull.present?
    class_names << " disabled" if disabled
    link_to t("views.buttons.edit"), path, class: class_names
  end

  def back_to_index_link_to(path, disabled: false, pull: nil)
    class_names = "btn btn-default"
    class_names << " pull-" + pull if pull.present?
    class_names << " disabled" if disabled
    link_to t("views.buttons.back"), path, class: class_names
  end

  def back_link_to(path, disabled: false, pull: nil)
    class_names = "btn btn-default"
    class_names << " pull-" + pull if pull.present?
    class_names << " disabled" if disabled
    link_to t("views.buttons.back"), path, class: class_names
  end

  def save_button_tag(disabled: false, pull: nil)
    class_names = "btn btn-default"
    class_names << " pull-" + pull if pull.present?
    class_names << " disabled" if disabled
    button_tag t("views.buttons.create"), class: class_names, form: "form"
  end

  def show_icon_link_to(path)
    #link_to path, class: "btn", data: { toggle: "tooltip", "original-title" => t("views.buttons.show") } do
    #  show_icon
    #end
    link_to t("views.buttons.show"), path, class: "btn btn-default"
  end

  def new_icon_link_to(path)
    #link_to path, class: "btn", data: { toggle: "tooltip", "original-title" => t("views.buttons.new") } do
    #  new_icon
    #end
    link_to t("views.buttons.new"), path, class: "btn btn-default"
  end

  def edit_icon_link_to(path)
    #link_to path, class: "btn", data: { toggle: "tooltip", "original-title" => t("views.buttons.edit") } do
    #  edit_icon
    #end
    link_to t("views.buttons.edit"), path, class: "btn btn-default"
  end

  def show_icon
    #icon("glyphicon-info-sign")
    icon("glyphicon-play-circle")
  end

  def new_icon
    icon("glyphicon-plus")
  end

  def edit_icon
    icon("glyphicon-edit")
  end

  def destroy_icon
    icon("glyphicon-remove-circle")
  end

  def exclamation_icon
    "<span class=\"glyphicon glyphicon-exclamation-sign\", style=\"color: red;\"></span>".html_safe
    #icon("glyphicon-exclamation-sign")
  end

  def icon(icon_name)
    "<span class=\"glyphicon #{icon_name}\"></span>".html_safe
  end

end

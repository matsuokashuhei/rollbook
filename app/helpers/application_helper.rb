module ApplicationHelper

  def weekday_ja(cwday)
    { 1 => "月", 2 => "火", 3 => "水", 4 => "木", 5 => "金", 6 => "土", 7 => "日" }[cwday]
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
    #link_to path, class: class_names do
    #  content_tag(:span, " #{t("views.buttons.new")}", class: "glyphicon glyphicon-user")
    #end
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

  def controller?(controllers)
    controllers.each do |controller|
      return true if params[:controller] == controller
    end
    return false
  end

end

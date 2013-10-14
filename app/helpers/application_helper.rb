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

  def show_icon_link_to(path)
    link_to path, class: "btn", data: { toggle: "tooltip", "original-title" => "見る" } do
      show_icon
    end
  end

  def edit_icon_link_to(path)
    link_to path, class: "btn", data: { toggle: "tooltip", "original-title" => "変更する" } do
      edit_icon
    end
  end

  def show_icon
    #icon("glyphicon-info-sign")
    icon("glyphicon-play-circle")
  end

  def edit_icon
    icon("glyphicon-edit")
  end

  def destroy_icon
    icon("glyphicon-remove-circle")
  end

  def icon(icon_name)
    "<span class=\"glyphicon #{icon_name}\"></span>".html_safe
  end

end

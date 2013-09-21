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
end

module ApplicationHelper
  def weekday_ja(cwday)
    { 1 => "月", 2 => "火", 3 => "水", 4 => "木", 5 => "金", 6 => "土", 7 => "日" }[cwday]
  end
end

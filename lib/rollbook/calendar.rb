module Rollbook

  module Calendar
  
  # 月の第何週か調べる。
  # === Args :: 日
  # === Retrurn :: 週
    def self.week_of_month(date: date)
      if date.month == 1
        case date.day
        when 4..10
          1
        when 11..17
          2
        when 18..24
          3
        when 25..31
          4
        else
          0
        end
      else
        case date.day
        when 1..7
          1
        when 8..14
          2
        when 15..21
          3
        when 22..28
          4
        else
          5
        end
      end
    end
  
  end

end
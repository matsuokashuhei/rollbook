module Rollbook

  module Calendar
  
    def self.business_days(month: Date.today.strftime('%Y%m'))
      self.days(month: month) - Holiday.days_off(month: month).pluck(:date)
    end

    # 月の日を返す
    def self.days(month: Date.today.strftime('%Y%m'))
      beginning_of_month = "#{month}01".to_date
      end_of_month = beginning_of_month.end_of_month
      (beginning_of_month..end_of_month).to_a
    end

    # 月の特定の曜日の日を返す
    def self.days_of_week(month: Date.today.strftime('%Y%m'), wday:)
      days = self.business_days(month: month)
      days.select {|day|
        day.wday == wday
      }
    end

    # 月の日曜日を返す
    def self.sundays(month: month)
      days_of_week(month: month, wday: 0)
    end

    # 月の月曜日を返す
    def self.mondays(month: month)
      days_of_week(month: month, wday: 1)
    end

    # 月の火曜日を返す
    def self.tuesdays(month: month)
      days_of_week(month: month, wday: 2)
    end

    # 月の水曜日を返す
    def self.wednesdays(month: month)
      days_of_week(month: month, wday: 3)
    end

    # 月の木曜日を返す
    def self.thursdays(month: month)
      days_of_week(month: month, wday: 4)
    end

    # 月の金曜日を返す
    def self.fridays(month: month)
      days_of_week(month: month, wday: 5)
    end

    # 月の土曜日を返す
    def self.saturdays(month: month)
      days_of_week(month: month, wday: 6)
    end

    # 月の第何週か調べる。
    # === Args :: 日
    # === Retrurn :: 週
    def self.week_of_month(date: date)
      days_of_week = self.days_of_week(month: date.strftime('%Y%m'), wday: date.wday)
      days_of_week.index(date).try(:+, 1) 
    end

  end

end

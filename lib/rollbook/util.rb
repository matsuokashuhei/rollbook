module Rollbook::Util
    
  module Month
    # 月の初めの日を返す
    def self.beginning_of_month(month = Date.today.strftime('%Y%m'))
      Date.new(month[0, 4].to_i, month[4, 2].to_i, 1)
    end
    # 月の最後の日を返す。
    def self.end_of_month(month = Date.today.strftime('%Y%m'))
      self.beginning_of_month(month).end_of_month
    end
    # 月の全ての日を返す。
    def self.days_of_month(month = Date.today.strftime('%Y%m'))
       beginning_of_month = beginning_of_month(month)
      (beginning_of_month..beginning_of_month.end_of_month).map {|date| date }
    end
  end

end
# == Schema Information
#
# Table name: holidays
#
#  id         :integer          not null, primary key
#  date       :date
#  created_at :datetime
#  updated_at :datetime
#

class Holiday < ActiveRecord::Base
  
  # 営業日
  def self.workday?(date)
    holiday?(date).!
  end

  # 休業日
  def self.holiday?(date)
    Holiday.exists?(date: date)
  end

  # 休業日
  def self.days_off(month: Date.today.strftime('%Y%m'))
    beginning_of_month = "#{month}01".to_date
    end_of_month = beginning_of_month.end_of_month
    Holiday.where(date: [beginning_of_month..end_of_month]).order(:date)
  end

end

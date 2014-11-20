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

end

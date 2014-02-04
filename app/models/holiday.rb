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
end

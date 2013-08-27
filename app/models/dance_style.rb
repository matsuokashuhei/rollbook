# == Schema Information
#
# Table name: dance_styles
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#  order_no   :integer
#

class DanceStyle < ActiveRecord::Base
  has_many :courses
end

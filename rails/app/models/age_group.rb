# == Schema Information
#
# Table name: age_groups
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#  order_no   :integer
#

class AgeGroup < ActiveRecord::Base
end

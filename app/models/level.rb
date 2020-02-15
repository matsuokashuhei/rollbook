# == Schema Information
#
# Table name: levels
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#  order_no   :integer
#

class Level < ActiveRecord::Base

  has_many :courses

  #default_scope ->{ order(:order_no) }

  validates :name, presence: true
  validates :name, uniqueness: true

end

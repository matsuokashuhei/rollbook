# == Schema Information
#
# Table name: studios
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  note       :string(255)
#  school_id  :integer
#  created_at :datetime
#  updated_at :datetime
#  open_date  :date
#  close_date :date
#

class Studio < ActiveRecord::Base
  belongs_to :school
  has_many :timetables
  default_scope -> { order("studios.open_date") }
  #validates :name, :school_id, presence: true
  validates :school_id, presence: true
end
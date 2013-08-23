class Studio < ActiveRecord::Base
  belongs_to :school
  has_many :timetables
  default_scope -> { order("studios.open_date") }
  #validates :name, :school_id, presence: true
  validates :school_id, presence: true
end

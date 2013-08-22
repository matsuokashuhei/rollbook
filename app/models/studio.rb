class Studio < ActiveRecord::Base
  belongs_to :school
  has_many :timetables
  default_scope order("open_date")
end

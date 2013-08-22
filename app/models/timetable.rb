class Timetable < ActiveRecord::Base
  belongs_to :studio
  belongs_to :time_slot
  has_many :courses
end

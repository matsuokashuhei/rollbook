class Course < ActiveRecord::Base
  belongs_to :timetable
  belongs_to :instructor
  belongs_to :dance_style
  belongs_to :levels
end

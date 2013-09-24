# == Schema Information
#
# Table name: time_slots
#
#  id         :integer          not null, primary key
#  start_time :time
#  end_time   :time
#  created_at :datetime
#  updated_at :datetime
#

class TimeSlot < ActiveRecord::Base

  has_many :timetables

  validates :start_time, :end_time, presence: true

end

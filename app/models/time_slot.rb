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

  scope :timing, -> (start_time) {
    time = Time.new(2000, 1, 1, *start_time.split(':'))
    start_time = time.strftime('%H:%M')
    end_time = (time + 70.minutes).strftime('%H:%M')
    where(start_time: start_time, end_time: end_time).first
  }

end

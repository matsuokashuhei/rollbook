# == Schema Information
#
# Table name: timetables
#
#  id           :integer          not null, primary key
#  studio_id    :integer
#  weekday      :integer
#  time_slot_id :integer
#  created_at   :datetime
#  updated_at   :datetime
#

class Timetable < ActiveRecord::Base
  belongs_to :studio
  belongs_to :time_slot
  has_many :courses
end

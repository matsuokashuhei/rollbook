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

  WEEKDAYS = {
    1 => "月", 2 => "火", 3 => "水", 4 => "木", 5 => "金", 6 => "土", 7 => "日"
  }

  belongs_to :studio
  belongs_to :time_slot
  has_many :courses

  validates :studio_id, :weekday, :time_slot_id, presence: true
  validates :time_slot_id, uniqueness: { scope: [:studio_id, :weekday] }

  default_scope -> { order(:weekday) }

  def weekday_ja
    WEEKDAYS[weekday]
  end

end

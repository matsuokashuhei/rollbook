# == Schema Information
#
# Table name: courses
#
#  id             :integer          not null, primary key
#  timetable_id   :integer
#  instructor_id  :integer
#  dance_style_id :integer
#  level_id       :integer
#  age_group_id   :integer
#  open_date      :date
#  close_date     :date
#  note           :text
#  monthly_fee    :integer
#  created_at     :datetime
#  updated_at     :datetime
#

class Course < ActiveRecord::Base

  belongs_to :timetable
  belongs_to :instructor
  belongs_to :dance_style
  belongs_to :level
  has_many :lessons

  scope :date_is, ->(date = Date.today) {
    where("courses.open_date <= ? and ? <= coalesce(courses.close_date, '9999-12-31')", date, date)
  }

  validates :timetable_id, :instructor_id, :dance_style_id, :level_id, :monthly_fee, :open_date, presence: true

  def name
    "#{self.dance_style.name}#{self.level.name}　#{self.instructor.name}"
  end
end

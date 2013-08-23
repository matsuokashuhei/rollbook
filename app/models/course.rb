class Course < ActiveRecord::Base

  belongs_to :timetable
  belongs_to :instructor
  belongs_to :dance_style
  belongs_to :level

  scope :date_of, ->(date = Date.today) {
    where("open_date <= ? and ? <= coalesce(close_date, '9999-12-31')", date, date)
  }

  validates :timetable_id, :instructor_id, :dance_style_id, :level_id, :open_date, presence: true
end

# == Schema Information
#
# Table name: lessons
#
#  id         :integer          not null, primary key
#  course_id  :integer
#  date       :date
#  status     :string(255)
#  note       :text
#  created_at :datetime
#  updated_at :datetime
#

class Lesson < ActiveRecord::Base

  STATUSES = {
    NONE: "0",
    IN_PROCESS: "1",
    FINISHED: "2",
  }

  belongs_to :course
  has_many :rolls

  validates :course_id, :date, :status, presence: true
  validates :date, uniqueness: { scope: :course_id }

  default_scope -> { order(:date, :course_id) }

  scope :fixed, -> {
    where(status: "2")
  }

  scope :month, -> (month) {
    if month.present?
      where('"date" between ? and ?', month.to_date, month.to_date.end_of_month)
    end
  }

  def edit?
    self.status != STATUSES[:FINISHED] && self.date <= Date.today
  end

  def fix?
    return false if self.rolls.size == 0
    return false if self.rolls.select { |roll| roll.status == "0" }.size > 0
    return false if self.status == "2"
    true
  end

  def prev_lesson
    one_week_before = date - 7.day
    Lesson.find_by(course_id: course_id, date: one_week_before)
  end

  def next_lesson
    one_week_after = date + 7.day
    Lesson.find_by(course_id: course_id, date: one_week_after)
  end

end

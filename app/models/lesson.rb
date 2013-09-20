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
  belongs_to :course
  has_many :rolls

  def prev_lesson
    one_week_before = date - 7.day
    Lesson.find_by(course_id: course_id, date: one_week_before)
  end

  def next_lesson
    one_week_after = date + 7.day
    Lesson.find_by(course_id: course_id, date: one_week_after)
  end

end

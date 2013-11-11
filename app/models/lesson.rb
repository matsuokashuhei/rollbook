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

  def find_or_initialize_rolls
    # クラスを受講中の会員と、休会中の会員の出欠情報を作る。
    rolls = []
    MembersCourse.where(course_id: self.course_id).active(self.date).each do |members_course|
      roll = Roll.find_or_initialize_by(lesson_id: self.id,
                                        member_id: members_course.member_id)
      roll.status = "0" if roll.new_record?
      # 休会中
      roll.status = "5" if Recess.exists?(members_course_id: members_course.id,
                                          month: self.date.strftime("%Y%m"))
      rolls << roll
    end
    rolls
  end

end

# == Schema Information
#
# Table name: lessons
#
#  id           :integer          not null, primary key
#  course_id    :integer
#  date         :date
#  status       :string(255)
#  note         :text
#  created_at   :datetime
#  updated_at   :datetime
#  rolls_status :string(255)
#

class Lesson < ActiveRecord::Base

  STATUS = {
    UNFIXED: "0",
    ON_SCHEDULE: "1",
    CANCEL_BY_INSTRUCTOR: "2",
    CANCEL_BY_OTHERS: "3",
  }

  ROLLS_STATUS = {
    NONE: "0",
    IN_PROCESS: "1",
    FINISHED: "2",
  }

  belongs_to :course
  has_many :rolls

  validates :course_id, :date, :rolls_status, presence: true
  validates :date, uniqueness: { scope: :course_id }

  #default_scope -> { order(:date, :course_id) }

  scope :fixed, -> {
    where(rolls_status: "2")
  }

  scope :for_month, -> (month) {
    if month.present?
      beginning_of_month = "#{month}01".to_date
      end_of_month = beginning_of_month.end_of_month
      where(date: [beginning_of_month..end_of_month])
    end
  }

  def editable?
    [
      # 今日以前である。
      date <= Date.today,
      # レッスンの状態
      status.presence_in([STATUS[:UNFIXED], STATUS[:ON_SCHEDULE],]),
      # 出欠の状態
      rolls_status.presence_in([ROLLS_STATUS[:NONE], ROLLS_STATUS[:IN_PROCESS],]),
    ].all?
  end

  def in_process?
    self.rolls_status == ROLLS_STATUS[:NONE] || self.rolls_status == ROLLS_STATUS[:IN_PROCESS]
  end

  def fix?
    return false if self.rolls.size == 0 && self.course.members_courses.active(self.date).size > 0
    return false if self.rolls.select { |roll| roll.status == "0" }.size > 0
    return false if self.rolls_status == ROLLS_STATUS[:FINISHED]
    true
  end

  def fixed?
    return self.rolls_status == ROLLS_STATUS[:FINISHED]
  end

  def fix
    self.rolls_status = ROLLS_STATUS[:FINISHED]
    self.save
  end

  def prev_lesson
    one_week_before = date - 7.day
    Lesson.find_by(course_id: course_id, date: one_week_before)
    #Lesson.find_or_initialize_by(course_id: course_id, date: one_week_before)
  end

  def next_lesson
    one_week_after = date + 7.day
    Lesson.find_by(course_id: course_id, date: one_week_after)
    #Lesson.find_or_initialize_by(course_id: course_id, date: one_week_after)
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

  def reset_rolls
    self.rolls.each do |roll|
      if roll.status == "4"
        roll.cancel_substitute
      else
        roll.destroy
      end
    end
    find_or_initialize_rolls
  end

end

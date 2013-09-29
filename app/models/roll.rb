# == Schema Information
#
# Table name: rolls
#
#  id                 :integer          not null, primary key
#  lesson_id          :integer
#  member_id          :integer
#  status             :string(255)
#  substitute_roll_id :integer
#  created_at         :datetime
#  updated_at         :datetime
#

class Roll < ActiveRecord::Base

  STATUS = {
    "0" => "未定",
    "1" => "出席",
    "2" => "欠席",
    "3" => "欠席",
    "4" => "振替",
    "5" => "休会",
    "6" => "体験",
  }
  STATUS_ = {
    NONE: "0",
    PRESENT: "1",
    ABSENT: "2",
    ABSENT_SUB: "3",
    SUBSTITUTE: "4",
    RECESS: "5",
    TRIAL: "6",
  }


  belongs_to :lesson
  belongs_to :member

  validates :lesson_id, :member_id, :status, presence: true
  validates :member_id, uniqueness: { scope: :lesson_id }

  default_scope -> { order(:lesson_id, :member_id) }

  scope :absent, -> {
    where(status: "2")
  }

  scope :member, ->(member_id) {
    where(member_id: member_id)
  }

  scope :course, ->(course_id) {
    joins(:lesson).where("lessons.course_id = ?", course_id)
  }

  scope :details, -> {
    order_columns = ["lessons.date", "schools.open_date", "studios.open_date", "time_slots.start_time"]
    joins(lesson: [course: [[timetable: [[studio: :school], :time_slot]], :dance_style, :level, :instructor]]).order("lessons.date, time_slots.start_time").order(order_columns)
  }

  def status_name
    STATUS[status]
  end

  def substitute(lesson)
    # 振替したレッスンの登録
    substitute_roll = Roll.create(lesson_id: lesson.id,
                                  member_id: self.member_id,
                                  status: "4",
                                  substitute_roll_id: self.id)
    # 欠席したレッスンの更新
    self.update_attributes(status: "3",
                           substitute_roll_id: substitute_roll.id)
  end

  def cancel_substitute
    absent_roll = Roll.find(substitute_roll_id)
    absent_roll.update_attributes(status: "2", substitute_roll_id: nil)
    destroy
  end

  def substitute_roll
    Roll.find(substitute_roll_id) if substitute_roll_id.present?
  end

end

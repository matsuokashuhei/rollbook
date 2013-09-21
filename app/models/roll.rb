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
  }

  belongs_to :lesson
  belongs_to :member

  scope :details, -> {
    joins(lesson: [course: [[timetable: [[studio: :school], :time_slot]], :dance_style, :level, :instructor]]).order("lessons.date, time_slots.start_time")
  }

  def status_name
    STATUS[status]
  end

  def substitute!(lesson)
    # 振替したレッスンの登録
    substitute_roll = Roll.create!(lesson_id: lesson.id,
                                   member_id: self.member_id,
                                   status: "4",
                                   substitute_roll_id: self.id)
    # 欠席したレッスンの更新
    self.update_attributes!(status: "3",
                            substitute_roll_id: substitute_roll.id)
  end

  def substitute_roll
    Roll.find(substitute_roll_id) if substitute_roll_id.present?
  end
end

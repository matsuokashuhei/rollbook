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
    # 未定
    NONE: "0",
    # 出席
    ATTENDANCE: "1",
    # 欠席
    ABSENCE: "2",
    #ABSENT_SUB: "3",
    # 振替
    SUBSTITUTE: "4",
    # 休会
    RECESS: "5",
    # 休講
    CANCEL: "6",
  }
  
  # attend 出席する
  # attendance 出席
  # absent from 欠席する
  # absence 欠席


  #----------------
  # Relations
  #----------------
  belongs_to :lesson
  belongs_to :member

  #----------------
  # Validations
  #----------------
  validates :lesson_id, :member_id, :status, presence: true
  validates :member_id, uniqueness: { scope: :lesson_id }

  #----------------
  # Scopes
  #----------------
  scope :attendances, -> {
    where status: STATUS[:ATTENDANCE]
  }
  scope :absences, -> {
    where(status: [STATUS[:ABSENCE], STATUS[:CANCEL],]).where(substitute_roll_id: nil)
  }
  scope :substitutes, -> {
    where status: STATUS[:SUBSTITUTE]
  }
  scope :recesses, -> {
    where status: STATUS[:RECESS]
  }

  scope :member, ->(member_id) {
    where(member_id: member_id)
  }

  scope :course, ->(course_id) {
    joins(:lesson).where("lessons.course_id = ?", course_id)
  }

  scope :details, -> {
    joins(lesson: [course: [[timetable: [[studio: :school], :time_slot]], :dance_style, :level, :instructor]])
  }

  #----------------
  # Methods
  #----------------
  def substitute
    save
    # 欠席した出席簿の検索
    substitute_roll = Roll.find(substitute_roll_id)
    substitute_roll.update(substitute_roll_id: id) if substitute_roll.substitute_roll_id.nil?
  end

  def cancel_substitute
    substitute_roll = Roll.find(substitute_roll_id)
    substitute_roll.update(substitute_roll_id: nil)
    logger.info("substitute_roll: #{substitute_roll}")
    destroy
  end

  def substitute_roll
    Roll.find(substitute_roll_id) if substitute_roll_id.present?
  end

  # def cancel_lesson
  #   case self.status.to_i
  #   when 0,1,2
  #     self.status = "6"
  #     self.save
  #   when 4
  #     self.cancel_substitute
  #   end
  # end

end

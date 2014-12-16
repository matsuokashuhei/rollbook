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

  # STATUS = {
  #   "0" => "未定",
  #   "1" => "出席",
  #   "2" => "欠席",
  #   #"3" => "欠席",
  #   "4" => "振替",
  #   "5" => "休会",
  #   "6" => "休講",
  # }
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
  scope :presences, -> {
    where status: "1"
  }

  scope :absences, -> {
    #where status: ["2", "3", "6"]
    where(status: ["2", "6"]).where(substitute_roll_id: nil)
  }

  scope :substitutes, -> {
    where status: "4"
  }

  scope :recesses, -> {
    where status: "5"
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
    #self.update_attributes(status: "3", substitute_roll_id: substitute_roll.id)
    self.update_attributes(substitute_roll_id: substitute_roll.id)
  end

  def cancel_substitute
    absent_roll = Roll.find(substitute_roll_id)
    absent_roll.update_attributes(substitute_roll_id: nil)
    destroy
  end

  def substitute_roll
    Roll.find(substitute_roll_id) if substitute_roll_id.present?
  end

  def cancel_lesson
    case self.status.to_i
    when 0,1,2
      self.status = "6"
      self.save
    when 4
      self.cancel_substitute
    end
  end

end

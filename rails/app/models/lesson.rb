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

  #----------------
  # Relations
  #----------------
  belongs_to :course
  has_many :rolls

  #----------------
  # Validations
  #----------------
  validates :course_id, :date, :rolls_status, presence: true
  validates :date, uniqueness: { scope: :course_id }

  #----------------
  # Scopes
  #----------------
  # 出欠が確定しているレッスン
  scope :fixed, -> {
    where(rolls_status: ROLLS_STATUS[:FINISHED])
  }

  # 特定の月のレッスン
  scope :for_month, -> (month) {
    if month.present?
      beginning_of_month = "#{month}01".to_date
      end_of_month = beginning_of_month.end_of_month
      where(date: [beginning_of_month..end_of_month])
    end
  }
  
  # 特定の期間内のレッスン
  scope :date_range, -> (from: from, to: Date.new(9999, 12, 31)) {
    where(date: [from..to])
  }
  
  # インストラクターが欠勤したレッスン
  scope :canceled_by_instructor, -> {
    where(status: STATUS[:CANCEL_BY_INSTRUCTOR])
  }

  #----------------
  # Methods
  #----------------
  # クラス別の最も過去に欠席したレッスンのクラスと日を返す。
  # @param [Integer] membrer_id 会員ID
  # @return [Hash]
  def self.oldest_absence_per_course(member_id:)
    Lesson.joins(:course)
          .joins(Course.joins(:members_courses).join_sources)
          .joins(:rolls)
          .merge(Roll.where(member_id: member_id))
          .merge(MembersCourse.where(member_id: member_id))
          .merge(MembersCourse.substitutable)
          .merge(Roll.where(status: [Roll::STATUS[:ABSENCE], Roll::STATUS[:CANCEL]])
                     .where(substitute_roll_id: nil))
          .group(:course_id)
          .pluck(:course_id, 'min(lessons.date)')
          .map { |row| Lesson.where(course_id: row[0], date: row[1]).try(:first) }
          .sort_by { |row| row.date }
  end

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

  def fixable?
    return false if self.rolls.select { |roll| roll.status == "0" }.size > 0
    return false if self.rolls.size == 0 && self.course.members_courses.active(self.date).size > 0
    return true
  end

  def fixed?
    return self.rolls_status == ROLLS_STATUS[:FINISHED]
  end

  def fix
    self.rolls_status = ROLLS_STATUS[:FINISHED]
    self.save
  end
  
  def unfix
    self.rolls_status = ROLLS_STATUS[:IN_PROCESS]
    self.save
  end

  # 出席簿を検索する。出席簿がない場合は作る。
  def find_or_initialize_rolls
    # 受講している会員の検索
    course.members_courses.active(date).map do |members_course|
      Roll.find_or_initialize_by(lesson_id: id, member_id: members_course.member_id) do |roll|
        # 休会の確認
        unless members_course.in_recess?(date.strftime('%Y%m'))
          roll.status = Roll::STATUS[:NONE]
        else
          roll.status = Roll::STATUS[:RECESS]
        end
      end
    end
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

  # 罰金を計算する。
  def cancellation_fee
    # インストラクターの欠勤による休講以外は罰金はない。
    return 0 unless status == STATUS[:CANCEL_BY_INSTRUCTOR]
    # 休講の場合は、レッスンの日に在籍している会員数×週割の月謝※税込
    members_courses = course.members_courses.active(date).select {|members_course| members_course.in_recess?(date.strftime("%Y%m")) == false }
    (Rollbook::Money.include_consumption_tax(course.monthly_fee) * members_courses.count * 0.25).to_i
  end

end

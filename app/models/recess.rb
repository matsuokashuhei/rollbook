# == Schema Information
#
# Table name: recesses
#
#  id                :integer          not null, primary key
#  members_course_id :integer
#  month             :string(255)
#  status            :string(255)
#  note              :text
#  created_at        :datetime
#  updated_at        :datetime
#

class Recess < ActiveRecord::Base

  belongs_to :members_course

  validates :members_course_id, :month, :status, presence: true
  validates :month, uniqueness: { scope: :members_course_id }
  validate :month, :six_months
  validate :month, :present_rolls

  default_scope -> { order(:month) }

  def create?
    rolls = members_course.rolls.joins(:lesson)
    rolls = rolls.where!("to_char(lessons.date, 'yyyy/mm') = ?", month)
    rolls = rolls.where!("lessons.status = ?", "2")
    rolls = rolls.where!("rolls.status in (?)", ["1", "3"])
    rolls.count > 0
  end

  def delete?
    rolls = members_course.rolls.joins(:lesson)
    rolls = rolls.where!("to_char(lessons.date, 'yyyy/mm') = ?", month)
    rolls = rolls.where!("lessons.status = ?", "2")
    rolls = rolls.where!("rolls.status = ?", "5")
    rolls.count == 0
  end

  def present_rolls
    if create?
      errors.add(:base, "%sはすでにレッスンを受けているので休会することはできません。" % (month.sub("/", "年") + "月"))
    end
  end

  def six_months
    months = (1..6).map {|i| (month.to_date - i.month).strftime("%Y/%m") }
    recesses = Recess.where("members_course_id = ? and month in (?)", members_course_id, months)
    if recesses.count == 6
      errors.add(:base, "6ヶ月以上続けて休会できません。")
    end
  end
end

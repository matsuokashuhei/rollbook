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

  STATUSES = {
    UNPAID: "0",
    PAID: "1",
    NONE: "2",
  }

  belongs_to :members_course

  validates :members_course_id, :month, :status, presence: true
  validates :month, uniqueness: { scope: :members_course_id }
  validate :month, :six_months
  validate :month, :present_rolls

  default_scope -> { order(:month) }

  def create?
    # レッスンを受けていない場合は休会できる。
    members_course = self.members_course
    beginning_of_month = (month + "01").to_date
    end_of_month = beginning_of_month.end_of_month
    Lesson.joins(:rolls).where(rolls: { member_id: members_course.member_id }).scoping do
      Lesson.where(course_id: members_course.course_id).scoping do
        Lesson.where("date >= ?", beginning_of_month).where("date <= ?", end_of_month).scoping do
          Lesson.fixed.each do |lesson|
            return false
          end
        end
      end
    end
    true
  end

  def delete?
    # レッスンが確定していない場合は休会を取り消せる。
    members_course = self.members_course
    beginning_of_month = (month + "/01").to_date
    end_of_month = beginning_of_month.end_of_month
    Lesson.joins(:rolls).where(rolls: { member_id: members_course.member_id }).scoping do
      Lesson.where(course_id: members_course.course_id).scoping do
        Lesson.where("date >= ?", beginning_of_month).where("date <= ?", end_of_month).scoping do
          Lesson.fixed.each do |lesson|
            return false
          end
        end
      end
    end
    true
  end

  def present_rolls
    unless create?
      errors.add(:base, "%sはすでにレッスンを受けているので休会することはできません。" % month)
    end
  end

  def six_months
    longest_month = (Date.today + 6.month).strftime("%Y%m")
    if month > longest_month
      errors.add(:base, "6ヶ月以上先の休会は登録できません。")
    end
  end

  before_validation do
    self.month.sub!("/", "")
  end

  after_find do
    self.month = self.month[0..3] + "/" + self.month[4..5]
  end

end

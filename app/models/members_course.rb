# == Schema Information
#
# Table name: members_courses
#
#  id           :integer          not null, primary key
#  member_id    :integer
#  course_id    :integer
#  begin_date   :date
#  end_date     :date
#  note         :text
#  introduction :boolean
#  created_at   :datetime
#  updated_at   :datetime
#

class MembersCourse < ActiveRecord::Base

  belongs_to :member, class_name: "Member"
  belongs_to :course, class_name: "Course"
  has_many :recesses

  validates :member_id, :course_id, :begin_date, presence: true
  validates :course_id, uniqueness: { scope: :member_id }
  validate :begin_date, :after_enter_date
  validate :begin_date, :after_open_date
  #validate :begin_date, :weekday_of_course
  validate :end_date, :end_of_month
  validate :end_date, :term_dates
  validate :end_date, :no_recesses, if: Proc.new { self.end_date.present? }
  validates :member_id, :course_id, presence: true
  validates :course_id, uniqueness: { scope: :member_id }

  default_scope -> {
    order(:member_id, :begin_date, :course_id)
  }

  scope :active, -> (date = Date.today) {
    where("members_courses.begin_date <= ? and ? <= coalesce(members_courses.end_date, '9999-12-31')", date, date)
  }

  scope :details, -> {
    joins(course: [[timetable: [[studio: :school], :time_slot]], :dance_style, :level, :instructor]).order("members_courses.begin_date")
  }

  def after_enter_date
    unless member.enter_date <= begin_date
      errors.add(:begin_date, "は入会日より未来の日にしてください。")
    end
  end

  def after_open_date
    unless course.open_date <= begin_date
      errors.add(:begin_date, "はクラスが始まった日より未来の日にしてください。")
    end
  end

  def weekday_of_course
    unless begin_date.cwday == course.timetable.weekday
      errors.add(:begin_date, "はクラスと同じ曜日の日にしてください。")
    end
  end

  def end_of_month
    unless end_date == end_date.try(:end_of_month)
      errors.add(:end_date, "は月の終わりの日にしてください。")
    end
  end

  def term_dates
    return if end_date.blank?
    unless begin_date < end_date
      errors.add(:end_date, "は開始日より未来の日にしてください。")
    end
  end

  def no_recesses
    self.recesses.each do |recess|
      if recess.month > self.end_date.strftime("%Y/%m")
        errors.add(:base, "クラスを退会する場合は%sの休会を取り消ししてください。" % recess.decorate.month)
      end
    end
  end

  def rolls
    @rolls = Roll.member(member_id).course(course_id).details
  end

  def destroy?
    if self.recesses.count == 0
      if Roll.member(member_id).where("rolls.status > ?", "0").course(course_id).count == 0
        return true
      end
    end
    return false
  end

end

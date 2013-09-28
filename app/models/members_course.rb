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

  default_scope -> {
    order(:member_id, :begin_date, :course_id)
  }

  scope :details, -> {
    joins(course: [[timetable: [[studio: :school], :time_slot]], :dance_style, :level, :instructor]).order("members_courses.begin_date")
  }

  scope :term_dates, ->(date = Date.today) {
    where("members_courses.begin_date <= ? and ? <= coalesce(members_courses.end_date, '9999-12-31')", date, date)
  }

  def rolls
    @rolls = Roll.member(member_id).course(course_id).details
  end

  def delete?
    if recesses.count == 0
      if Roll.member(member_id).where("rolls.status > ?", "0").course(course_id).count == 0
        return true
      end
    end
    return false
  end
end

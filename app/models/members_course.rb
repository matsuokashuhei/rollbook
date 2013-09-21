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
  validates :member_id, :course_id, :begin_date, presence: true

  scope :details, -> {
    joins(course: [[timetable: [[studio: :school], :time_slot]], :dance_style, :level, :instructor]).order("members_courses.begin_date")
  }
  scope :date_is, ->(date = Date.today) {
    where("members_courses.begin_date <= ? and ? <= coalesce(members_courses.end_date, '9999-12-31')", date, date)
  }

  def rolls
    @rolls = Roll.joins(:lesson).where("lessons.course_id = ?", course_id).where("rolls.member_id = ?", member_id).order("lessons.date")
  end

end

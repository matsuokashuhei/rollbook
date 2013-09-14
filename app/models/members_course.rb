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

  scope :date_is, ->(date = Date.today) {
    where("members_courses.begin_date <= ? and ? <= coalesce(members_courses.end_date, '9999-12-31')", date, date)
  }

end

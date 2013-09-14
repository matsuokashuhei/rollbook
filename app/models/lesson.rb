# == Schema Information
#
# Table name: lessons
#
#  id         :integer          not null, primary key
#  course_id  :integer
#  date       :date
#  status     :string(255)
#  note       :text
#  created_at :datetime
#  updated_at :datetime
#

class Lesson < ActiveRecord::Base
  belongs_to :course
  has_many :rolls
end

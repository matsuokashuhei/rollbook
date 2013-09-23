class Recess < ActiveRecord::Base

  belongs_to :members_course

  validates :members_course_id, :month, :status, presence: true
  validates :month, uniqueness: { scope: :members_course_id }

  default_scope -> { order(:month) }

end

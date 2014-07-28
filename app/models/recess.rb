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
    NO_BANK: "3",
  }

  #----------------
  # Relations
  #----------------
  belongs_to :members_course

  #----------------
  # Validations
  #----------------
  validates :members_course_id, :month, :status, presence: true
  validates :month, uniqueness: { scope: :members_course_id }
  validates_with RecessValidator

  #----------------
  # Callbacks
  #----------------
  before_validation do
    self.month.sub!("/", "")
  end

  after_find do
    self.month = self.month[0..3] + "/" + self.month[4..5]
  end

  def deletable 
    logger.debug("month: #{month}")
    # レッスンが確定していない場合は休会を取り消せる。
    Lesson.for_month(month.gsub('/', ''))
      .where(course_id: members_course.course_id)
      .fixed
      .joins(:rolls)
      .where(rolls: { member_id: members_course.member_id })
      .exists?.!
  end

end

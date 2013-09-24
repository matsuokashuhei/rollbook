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

  default_scope -> { order(:month) }

  def six_months
    months = (1..6).map {|i| (month.to_date - i.month).strftime("%Y/%m") }
    recesses = Recess.where("members_course_id = ? and month in (?)", members_course_id, months)
    if recesses.count == 6
      errors.add(:base, "6ヶ月以上続けて休会できません。")
    end
  end
end

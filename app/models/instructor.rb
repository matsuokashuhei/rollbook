# == Schema Information
#
# Table name: instructors
#
#  id           :integer          not null, primary key
#  name         :string(255)
#  kana         :string(255)
#  team         :string(255)
#  phone        :string(255)
#  email_pc     :string(255)
#  email_mobile :string(255)
#  note         :text
#  created_at   :datetime
#  updated_at   :datetime
#

class Instructor < ActiveRecord::Base

  has_many :courses

  validates :name, :kana, :phone, presence: true
  validates :kana, format: { with: /\A[\p{katakana}ー－]+\Z/, message: "はカタカナで入力してください。" }
  validates :name, uniqueness: { scope: :team }

  default_scope -> { order(:kana) }

  def delete?
    courses.count == 0
  end
end

# == Schema Information
#
# Table name: instructors
#
#  id             :integer          not null, primary key
#  name           :string(255)
#  kana           :string(255)
#  team           :string(255)
#  phone          :string(255)
#  email_pc       :string(255)
#  email_mobile   :string(255)
#  note           :text
#  created_at     :datetime
#  updated_at     :datetime
#  transportation :integer
#

class Instructor < ActiveRecord::Base

  has_many :courses

  validates :name, presence: true
  validates :kana, format: { with: /\A[\p{katakana}ー－]+\Z/, message: "はカタカナで入力してください。" }, if: Proc.new { self.kana.present? }
  validates :name, uniqueness: { scope: :team }

  def destroy?
    courses.count == 0
  end

  # 最低保障を計算する。
  # 月の講師代と最低保証額を比較して、最低保証額の差分を計算する。
  def guaranteed_min_for(month: month)
    return 0 if (guaranteed_min || 0) == 0
    courses_fee = courses_fee_for(month: month)
    if courses_fee < guaranteed_min
      guaranteed_min - courses_fee
    else
      0
    end 
  end

  # 講師代を計算する。
  # 罰金は含まない。
  def courses_fee_for(month: month)
    end_of_month = Date.new(month[0, 4].to_i, month[4, 2].to_i, 1).end_of_month
    courses.active(end_of_month).map {|course| course.fee_for(month: month) }.inject(:+)
  end

  # 罰金を計算する。
  def penalty_for(month: month)
    courses.map {|course| course.penalty_for(month: month) }.inject(:+)
  end

  # 月の支給額を計算する。
  # 交通費は含まない。
  def fee_for(month: month)
    courses_fee = courses_fee_for(month: month)
    guaranteed_min_for_month = guaranteed_min_for(month: month)
    penalty = penalty_for(month: month)
    courses_fee + guaranteed_min_for_month - penalty
  end

end

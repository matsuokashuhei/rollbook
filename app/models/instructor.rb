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

  # 講師料を計算する。
  # *罰金は含まない。
  # @param [String] %Y%mという書式の年月
  # @return [Integer] 講師料の合計
  def lecture_fee(month: month)
    end_of_month = Rollbook::Util::Month.end_of_month(month)
    courses.opened(end_of_month).map {|course| course.lecture_fee(month: month) }.inject(:+)
  end

  # 罰金を計算する。
  # @param [String] %Y%mという書式の年月
  # @return [Integer] 罰金の合計
  def cancellation_fee(month: month)
    courses.map {|course| course.cancellation_fee(month: month) }.inject(:+)
  end

  # 給料を計算する。
  # @param [String] %Y%mという書式の年月
  # @return [Integer] 給料
  def salary(month: month)
    lecture_fee = lecture_fee(month: month)
    lecture_fee = guaranteed_min if lecture_fee < (guaranteed_min || 0)
    lecture_fee - cancellation_fee(month: month)
  end

end

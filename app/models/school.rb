# == Schema Information
#
# Table name: schools
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  zip        :string(255)
#  address    :string(255)
#  phone      :string(255)
#  note       :text
#  created_at :datetime
#  updated_at :datetime
#  open_date  :date
#  close_date :date
#

class School < ActiveRecord::Base

  has_many :studios
  has_many :users

  validates :name, :open_date, presence: true
  validates :name, uniqueness: true

  # スクールの全クラスの受講料の合計を計算する。
  # @param [String] %Y%mという書式の年月
  # @return [Integer] 受講料の合計
  def tuition_fee(month: month)
    studios.map {|studio| studio.tuition_fee(month: month) }.inject(:+) || 0
  end

end

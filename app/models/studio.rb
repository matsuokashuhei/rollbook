# == Schema Information
#
# Table name: studios
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  note       :string(255)
#  school_id  :integer
#  created_at :datetime
#  updated_at :datetime
#  open_date  :date
#  close_date :date
#

class Studio < ActiveRecord::Base

  belongs_to :school
  has_many :timetables

  validates :school_id, :name, :open_date, presence: true
  validates :name, uniqueness: { scope: :school_id }

  # スタジオの全クラスの受講料の合計を計算する。
  # @param [String] %Y%mという書式の年月
  # @return [Integer] 受講料の合計
  def tuition_fee(month: month = Date.today.strftime('%Y%m'))
    courses = Course.joins(timetable: :studio).where(studios: { id: id }).opened(Rollbook::Util::Month.end_of_month(month))
    courses.map {|course| course.tuition_fee(month: month) }.inject(:+) || 0
  end

end

# == Schema Information
#
# Table name: courses
#
#  id             :integer          not null, primary key
#  timetable_id   :integer
#  instructor_id  :integer
#  dance_style_id :integer
#  level_id       :integer
#  age_group_id   :integer
#  open_date      :date
#  close_date     :date
#  note           :text
#  monthly_fee    :integer
#  created_at     :datetime
#  updated_at     :datetime
#

class Course < ActiveRecord::Base

  belongs_to :timetable
  belongs_to :instructor
  belongs_to :dance_style
  belongs_to :level
  has_many :lessons
  has_many :members_courses
  has_many :members, through: :members_courses, source: :member

  def self.lesson_of_day(date)
    Course.opened(date).details
      .merge(Timetable.weekday(date.cwday))
      .merge(TimeSlot.order(:start_time))
      .merge(School.order(:open_date))
      .merge(Studio.order(:open_date))
  end

  # Scope
  scope :details, ->{
    joins([timetable: [[studio: :school], :time_slot]], :instructor, :dance_style, :level)
  }

  # 開講中のクラス
  scope :opened, -> (date = Date.today) {
    open_date = Course.arel_table[:open_date]
    close_date = Course.arel_table[:close_date]
    where(open_date.lteq(date)).where(close_date.eq(nil).or(close_date.gteq(date)))
  }

  # 閉講したクラス
  scope :closed, -> (date = Date.today) {
    close_date = Course.arel_table[:close_date]
    where(close_date.lteq(date))
  }

  # Validation
  validates :timetable_id, :instructor_id, :dance_style_id, :level_id, :monthly_fee, :open_date, presence: true
  validates :monthly_fee, numericality: { only_integer: true }
  validate :open_date, :beginning_of_month
  validate :term_courses
  validate :close_date, :end_of_month, if: Proc.new { self.close_date.present? }
  validate :close_date, :term_dates, if: Proc.new { self.close_date.present? }
  validate :close_date, :non_active_members, if: Proc.new { self.close_date.present? }

  def beginning_of_month
    return if open_date.nil?
    unless open_date == open_date.beginning_of_month
      errors.add(:open_date, "は月のはじめの日にしてください。")
    end
  end

  def end_of_month
    unless close_date == close_date.end_of_month
      errors.add(:close_date, "は月の終わりの日にしてください。")
    end
  end

  def term_dates
    unless open_date < close_date
      errors.add(:close_date, "は開始日より未来の日にしてください。")
    end
  end

  def term_courses
    Course.where(timetable_id: timetable_id).each do |other|
      next if id == other.id
      if open_date <= (other.close_date.present? ? other.close_date : Date.new(9999, 12, 31))
        if other.open_date <= (close_date.present? ? close_date : Date.new(9999, 12, 31))
          errors.add(:base, "%s〜%sの%sクラスと期間が重なっています。" % [other.open_date, other.close_date, other.name])
        end
      end
    end
  end

  def non_active_members
    self.members_courses.each do |members_course|
      if members_course.end_date.blank? || close_date < members_course.end_date
        errors.add(:base, "クラスを終了する場合、%sさんをクラスから退会してください。" % members_course.member.full_name)
      end
    end
  end

  def name
    "#{self.dance_style.name}#{self.level.name}　#{self.instructor.name}"
  end

  # その他
  def destroy?
    members_courses.count == 0
  end

  # 受講料の合計を計算する。
  # @param [String] %Y%mという書式の年月
  # @return [Integer] 受講料の合計
  def tuition_fee(month: month = Date.today.strftime('%Y%m'))
    end_of_month = Rollbook::Util::Month.end_of_month(month)
    members_courses.active(end_of_month).map {|members_course| members_course.tuition_fee(month: month) }.inject(:+) || 0
  end

  # 講師料の合計を計算する。
  # === Args :: 月
  # === Return :: 講師料
  def lecture_fee(month: month = Date.today.strftime('%Y%m'))
    end_of_month = Rollbook::Util::Month.end_of_month(month)
    members_courses.active(end_of_month).map {|members_course| members_course.lecture_fee(month: month) }.inject(:+) || 0
  end

  # インストラクターが休講した場合の罰金を計算する。
  # === Args :: 月
  # === Return :: 罰金
  def cancellation_fee(month: month = Date.today.strftime('%Y%m'))
    canceled_lessons = lessons.for_month(month).canceled_by_instructor
    return 0 if canceled_lessons.blank?
    canceled_lessons.map {|lesson| lesson.cancellation_fee }.inject(:+)
  end

end

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

  # Scope
  default_scope -> { order(:open_date) }

  scope :details, ->{
    joins([timetable: [[studio: :school], :time_slot]], :instructor, :dance_style, :level).order("schools.open_date, studios.open_date, timetables.weekday, time_slots.start_time, courses.open_date").order("schools.open_date, studios.open_date, timetables.weekday, time_slots.start_time")
  }

  scope :term_dates, ->(date = Date.today) {
    where("courses.open_date <= ? and ? <= coalesce(courses.close_date, '9999-12-31')", date, date)
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
    members_courses.each do |members_course|
      if members_course.end_date.blank? || close_date < members_course.end_date
        errors.add(:base, "クラスを終了する場合、会員をクラスから退会してください。")
      end

    end
  end

  # その他
  def delete?
    members_courses.count == 0
  end

  def name
    "#{self.dance_style.name}#{self.level.name}　#{self.instructor.name}"
  end

  def monthly_fee_with_tax
    (self.monthly_fee * 1.05).to_i
  end

end

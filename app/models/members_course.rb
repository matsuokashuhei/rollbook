# == Schema Information
#
# Table name: members_courses
#
#  id           :integer          not null, primary key
#  member_id    :integer
#  course_id    :integer
#  begin_date   :date
#  end_date     :date
#  note         :text
#  introduction :boolean
#  created_at   :datetime
#  updated_at   :datetime
#

class MembersCourse < ActiveRecord::Base

  #----------------
  # Relations
  #----------------
  belongs_to :member
  belongs_to :course
  has_many :recesses

  #----------------
  # Validations
  #----------------
  validates :member_id, :course_id, :begin_date, presence: true
  validates_with MembersCourseValidator

  #----------------
  # Scopes
  #----------------
  # 在籍しているクラス
  scope :active, -> (date = Date.today) {
    begin_date = MembersCourse.arel_table[:begin_date]
    end_date = MembersCourse.arel_table[:end_date]
    where(begin_date.lteq(date)).where(end_date.eq(nil).or(end_date.gteq(date)))
  }

  # 退籍したクラス
  scope :deactive, -> (date = Date.today) {
    end_date = MembersCourse.arel_table[:end_date]
    where(end_date.lteq(date))
  }
  
  scope :will_active, -> (date = Date.today) {
    begin_date = MembersCourse.arel_table[:begin_date]
    where(begin_date.gt(date))
  }

  scope :details, -> {
    joins(course: [[timetable: [:studio, :time_slot]], :dance_style, :level, :instructor])
  }

  # 振替の可否
  scope :substitutable, ->(substitutable = true) {
    where(substitutable: substitutable)
  }

  #----------------
  # Callbacks
  #----------------
  after_update MembersCourseCallbacks

  def deletable?
    #----------------------------
    # 休会している場合は消せない。
    #----------------------------
    if recesses.after_month(begin_date.strftime('%Y%m')).present?
      return false
    end
    #--------------------------------------
    # 出席簿に記録されている場合は消せない。
    #--------------------------------------
    # 受講クラスの出席簿を検索する。
    rolls = MembersQuery.new(member).find_rolls(self)
    # 未定以外があれば消せない。
    return rolls.select {|roll| roll.status.presence_in(['1', '2', '5', '6', ]) }.blank?
  end

  # インストラクター紹介であるかどうかを判定する。
  def introduction?
    return introduction
  end

  # 第何週入会かを調べる。
  def start_week_of_month
    Rollbook::Calendar.week_of_month(date: begin_date)
    #week_of_month(begin_date.day)
  end

  # 会員が休会中か判定する。
  # === Args :: 月
  def in_recess?(month)
    recesses.exists?(month: month)
  end
  
  # 会員が支払う受講料を計算する。
  # === Args :: 月
  # === Retrurn :: 受講料
  def tuition_fee(month: month)
    fee = course.monthly_fee
    # 退会している場合は0円
    return 0 if end_date.present? && end_date.strftime("%Y%m") < month
    # 休会中は0円
    return 0 if in_recess?(month)
    # 次月以降に入会する場合は0円    
    return 0 if begin_date.strftime("%Y%m") > month
    # 当月より過去に入会した場合は、１カ月分の月謝
    return fee if begin_date.strftime("%Y%m") < month
    # 当月に入会した場合は週割の月謝
    unit_price = fee / 4
    return unit_price + unit_price * (4 - start_week_of_month)
  end
  
  # インストラクターに支払う講師代を計算する。
  # === Args :: 月
  # === Retrurn :: 講師料
  def lecture_fee(month: month)
    fee = tuition_fee(month: month)
    if introduction?
      (fee * 0.6).to_i
    else
      (fee * 0.4).to_i
    end
  end

end

# == Schema Information
#
# Table name: members
#
#  id              :integer          not null, primary key
#  first_name      :string(255)
#  last_name       :string(255)
#  first_name_kana :string(255)
#  last_name_kana  :string(255)
#  gender          :string(255)
#  birth_date      :date
#  zip             :string(255)
#  address         :string(255)
#  phone_mobile    :string(255)
#  email_pc        :string(255)
#  email_mobile    :string(255)
#  note            :text
#  enter_date      :date
#  leave_date      :date
#  bank_account_id :integer
#  status          :string(255)
#  nearby_station  :string(255)
#  created_at      :datetime
#  updated_at      :datetime
#  phone_land      :string(255)
#  number          :string(255)
#

class Member < ActiveRecord::Base

  before_validation do
    self.status = STATUSES[:SECESSION] if leave_date.present?
  end

  STATUSES = {
    ADMISSION: "1",
    SECESSION: "2",
  }

  # -------------------------
  # 関連
  # -------------------------
  has_many :members_courses
  has_many :courses, through: :members_courses, source: :course
  has_many :rolls
  belongs_to :bank_account

  # -------------------------
  # バリデーター
  # -------------------------
  validates :first_name,
            :last_name,
            :first_name_kana,
            :last_name_kana,
            :status,
            :enter_date,
            presence: true
  validates :number, uniqueness: true, if: Proc.new { number.present? }
  validates :number, numericality: { greater_than: 0, less_than_or_equal_to: 999999 }, if: Proc.new { number.present? }
  validates :last_name_kana, :first_name_kana, format: { with: /\A[\p{hiragana}ー－]+\Z/, message: "はひらがなで入力してください。" }
  validates_with MemberValidator

  # -------------------------
  # スコープ
  # -------------------------

  scope :active, -> (date = Date.today.end_of_month) {
    enter_date = Member.arel_table[:enter_date]
    leave_date = Member.arel_table[:leave_date]
    where(enter_date.lteq(date)).where(leave_date.eq(nil).or(leave_date.gteq(date)))
  }
=begin
  # 受講中の会員（当月の入会、退会含む）
  scope :active, -> (month = Date.today.strftime("%Y%m")) {
    beginning_of_month = (month + "01").to_date.beginning_of_month
    end_of_month = beginning_of_month.end_of_month
    query = where(status: [STATUSES[:ADMISSION], STATUSES[:SECESSION]])
    query = query.where('"members"."enter_date" <= ?', end_of_month)
    query = query.where('coalesce("members"."leave_date", \'9999-12-31\') >= ?', end_of_month)
  }

  統計情報を作り直したら消す。
  # 入会した会員
  scope :registered, -> (month = Date.today.strftime("%Y%m")) {
    beginning_of_month = (month + "01").to_date.beginning_of_month
    end_of_month = beginning_of_month.end_of_month
    query = where(status: [STATUSES[:ADMISSION], STATUSES[:SECESSION]])
    query = query.where('"members"."enter_date" between ? and ?', beginning_of_month, end_of_month)
    query = query.where('coalesce("members"."leave_date", \'9999-12-31\') >= ?', end_of_month)
  }

  # 退会する会員
  scope :canceled, -> (month = Date.today.strftime("%Y%m")) {
    end_of_month = (month + "01").to_date.end_of_month
    query = where(status: [STATUSES[:ADMISSION], STATUSES[:SECESSION]])
    query = query.where(leave_date: end_of_month)
  }
=end

  scope :status, -> (status = nil) {
    if status.present?
      where(status: status)
    end
  }

  scope :with_rolls, -> {
    joins(:rolls)
  }

  def destroy?
    if members_courses.count == 0
      if bank_account.nil?
        return true
      end
    end
    return false
  end

  def active?
    self.status == STATUSES[:ADMISSION]
  end

  def nonactive?
    self.status == STATUSES[:SECESSION]
  end

  def full_name
    #"%s　%s" % [last_name, first_name]
    "#{last_name}　#{first_name}"
  end

end

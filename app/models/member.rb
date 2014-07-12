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
  validates :leave_date, presence: true, if: Proc.new { self.status == "2" }
  validate :leave_date, :leaved_all_courses, if: Proc.new { self.leave_date.present? }
  validate :check_withdraw

  def leaved_all_courses
    self.members_courses.each do |members_course|
      if members_course.end_date.blank?
        errors.add(:base, "スクールを退会する場合はその前に受講クラスを退会してください。")
        return
      end
      if leave_date < members_course.end_date
        errors.add(:base, "受講クラスの終了日より前には退会できません。")
      end
    end
  end

  def check_withdraw
    if leave_date.present? && status != '2'
      errors.add(:base, "退会する場合は、状態を退会をにしてください。")
    end
  end


  # -------------------------
  # スコープ
  # -------------------------
  default_scope -> { order(:last_name_kana, :first_name_kana) }

  # 受講中の会員（当月の入会、退会含む）
  scope :active, -> (month = Date.today.strftime("%Y%m")) {
    beginning_of_month = (month + "01").to_date.beginning_of_month
    end_of_month = beginning_of_month.end_of_month
    query = where(status: [STATUSES[:ADMISSION], STATUSES[:SECESSION]])
    query = query.where('"members"."enter_date" <= ?', end_of_month)
    query = query.where('coalesce("members"."leave_date", \'9999-12-31\') >= ?', end_of_month)
  }

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

  scope :number, -> (number = nil) {
    if number.present?
      where("number like ?", "%#{number}")
    end
  }

  scope :last_name, -> (last_name_kana = nil) {
    if last_name_kana.present?
      where("last_name_kana like ?", "#{last_name_kana}%")
    end
  }

  scope :first_name, -> (first_name_kana = nil) {
    if first_name_kana.present?
      where("first_name_kana like ?", "#{first_name_kana}%")
    end
  }

  scope :name_like, -> (last_name_kana = nil, first_name_kana = nil) {
    if last_name_kana.present? && first_name_kana.present?
      last_name(last_name_kana).first_name(first_name_kana)
    elsif last_name_kana.present?
      last_name(last_name_kana)
    elsif first_name_kana.present?
      first_name(first_name_kana)
    end
  }

  scope :status, -> (status = nil) {
    if status.present?
      where(status: status)
    end
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

  def total_monthly_fee(date)
    members_courses.active(date).joins(:course).sum("courses.monthly_fee")
  end

  def full_name
    #"%s　%s" % [last_name, first_name]
    "#{last_name}　#{first_name}"
  end

end

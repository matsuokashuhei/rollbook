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

  STATUSES = {
    # 体験は設計ミスため削除する。
    #TRIAL: "0",
    ADMISSION: "1",
    SECESSION: "2",
  }

  #STATUS = {
  #  # 体験は設計ミスため削除する。
  #  #"0" => "未入会",
  #  "1" => "入会",
  #  "2" => "退会",
  #}

  has_many :members_courses
  has_many :courses, through: :members_courses, source: :course
  has_many :rolls
  has_many :receipts
  belongs_to :bank_account

  validates :first_name,
            :last_name,
            :first_name_kana,
            :last_name_kana,
            :status,
            presence: true
  # 会員番号のチェックを無効にする。
  #validates :number, uniqueness: true, if: Proc.new { self.status != "0" }
  #validates :number, format: { with: /[0-9]{6}/, message: "は6桁の数字にしてください。" }, if: Proc.new { self.status != "0" }
  #validates :number, presence: true, if: Proc.new { self.status != "0" }
  validates :last_name_kana, :first_name_kana, format: { with: /\A[\p{hiragana}ー－]+\Z/, message: "はひらがなで入力してください。" }
  validates :enter_date, presence: true, if: Proc.new { self.status == "1" }
  validates :enter_date, absence: true, if: Proc.new { self.status == "0" }

  validates :leave_date, absence: true, if: Proc.new { self.status == "0" || self.status == "1" }
  validates :leave_date, presence: true, if: Proc.new { self.status == "2" }
  validate :leave_date, :leaved_all_courses, if: Proc.new { self.leave_date.present? }

  default_scope -> { order(:last_name_kana, :first_name_kana) }

  # 受講中の会員（当月の入会、退会含む）
  scope :active, -> (month = Date.today.strftime("%Y%m")) {
    beginning_of_month = (month + "01").to_date.beginning_of_month
    end_of_month = beginning_of_month.end_of_month
    query = where(status: [STATUSES[:ADMISSION], STATUSES[:SECESSION]])
    #query = query.where('"members"."enter_date" <= ?', beginning_of_month)
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

  scope :new_members, -> (month) {
    begin_date = (month + "01").to_date
    end_date = begin_date.end_of_month
    where(status: STATUSES[:ADMISSION]).where("members.enter_date >= ?", begin_date).where("members.enter_date <= ?", end_date).includes(:receipts).where(receipts: { id: nil })
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

  def leaved_all_courses
    self.members_courses.each do |members_course|
      if members_course.end_date.blank?
        errors.add(:base, "スクールを退会する場合はその前に受講クラスを退会してください。")
      end
      if leave_date < members_course.end_date
        errors.add(:base, "受講クラスの終了日より前には退会できません。")
      end
    end
  end

  def destroy?
    if members_courses.count == 0
      if bank_account.nil?
        return true
      end
    end
    return false
  end

  #def guest?
  #  self.status == STATUSES[:TRIAL]
  #end

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

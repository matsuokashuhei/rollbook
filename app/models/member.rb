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
#  phone           :string(255)
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
#

class Member < ActiveRecord::Base

  STATUSES = {
    GUEST: "0",
    ADMISSION: "1",
    SECESSION: "2",
  }

  STATUS = {
    "0" => "未入会",
    "1" => "入会",
    "2" => "退会",
  }

  has_many :members_courses
  has_many :courses, through: :members_courses, source: :course
  has_many :rolls
  has_many :receipts
  belongs_to :bank_account

  validates :number,
            :first_name,
            :last_name,
            :first_name_kana,
            :last_name_kana,
            :status,
            presence: true
  validates :number, uniqueness: true
  validates :number, format: { with: /[0-9]{6}/, message: "は6桁の数字にしてください。" }
  validates :last_name_kana, :first_name_kana, format: { with: /\A[\p{katakana}ー－]+\Z/, message: "はカタカナで入力してください。" }
  validates :enter_date, presence: true, if: Proc.new { self.status == "1" }
  validates :enter_date, absence: true, if: Proc.new { self.status == "0" }

  validates :leave_date, absence: true, if: Proc.new { self.status == "0" || self.status == "1" }
  validates :leave_date, presence: true, if: Proc.new { self.status == "2" }

  default_scope -> { order(:last_name_kana, :first_name_kana) }

  scope :active, -> {
    where(status: "1")
  }

  def delete?
    if members_courses.count == 0
      if bank_account.nil?
        return true
      end
    end
    return false
  end

  def total_monthly_fee(date)
    members_courses.active(date).joins(:course).sum("courses.monthly_fee")
  end

  def full_name
    "%s　%s" % [last_name, first_name]
  end

  def full_name_kana
    "%s　%s" % [last_name_kana, first_name_kana]
  end

end

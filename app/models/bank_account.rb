# == Schema Information
#
# Table name: bank_accounts
#
#  id               :integer          not null, primary key
#  holder_name      :string(255)
#  holder_name_kana :string(255)
#  bank_id          :string(255)
#  bank_name        :string(255)
#  branch_id        :string(255)
#  branch_name      :string(255)
#  account_number   :string(255)
#  status           :string(255)
#  note             :text
#  created_at       :datetime
#  updated_at       :datetime
#  receipt_date     :date
#  ship_date        :date
#  begin_date       :date
#  imperfect        :boolean
#  change_bank      :boolean
#

class BankAccount < ActiveRecord::Base

  has_many :members
  has_many :debits, -> { order(:tuition_id) }

  #validates :holder_name_kana, :status, presence: true
  validates :holder_name_kana, presence: true
  validates :holder_name_kana, uniqueness: { scope: [:bank_id, :branch_id] }
  validates :begin_date, absence: { message: "は書類不備のときは登録できません。" }, if: Proc.new { self.imperfect }
  validates :begin_date, absence: { message: "は口座変更のときは登録できません。" }, if: Proc.new { self.change_bank }

  default_scope -> { order(:holder_name_kana) }

  scope :active, -> (date = Date.today) {
    # 引落日が引数の日以下である。
    where("begin_date is not null and begin_date <= ?", date)
  }

  scope :in_process, -> (date = Date.today) {
    where('coalesce("begin_date", \'9999-12-31\') > ?', date).where(imperfect: false).where(change_bank: false)
  }

  scope :invalid, -> {
    where("imperfect = ? or change_bank = ?", true, true)
  }

  scope :name_like, -> (holder_name_kana = nil) {
    if holder_name_kana.present?
      where("holder_name_kana like ?", "#{holder_name_kana}%")
    end
  }

  def delete?
    self.members.count == 0
  end

  def active?
    if self.begin_date.present?
      self.begin_date <= Date.today
    else
      false
    end
  end

  def payable_members(date)
    payable_members = []
    members.active.each do |member|
      payable_members << member if member.members_courses.active(date).count > 0
    end
    payable_members
  end

end

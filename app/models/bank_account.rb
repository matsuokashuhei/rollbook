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
#

class BankAccount < ActiveRecord::Base

  has_many :members
  has_many :debits, -> { order(:month) }

  #validates :holder_name_kana, :status, presence: true
  validates :holder_name_kana, presence: true
  validates :holder_name_kana, uniqueness: { scope: [:bank_id, :branch_id] }

  default_scope -> { order(:holder_name_kana) }

  scope :active, -> (date = Date.today) {
    where("begin_date is not null and begin_date <= ?", date)
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

end

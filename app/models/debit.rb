# == Schema Information
#
# Table name: debits
#
#  id              :integer          not null, primary key
#  bank_account_id :integer
#  amount          :integer
#  status          :string(255)
#  note            :text
#  created_at      :datetime
#  updated_at      :datetime
#

class Debit < ActiveRecord::Base

  STATUSES = {
    SUCCESS: "1",
    FAILURE: "2",
    OTHERS: "3",
  }

  belongs_to :bank_account
  belongs_to :tuition
  has_many :receipts

  default_scope -> {
    order(:tuition_id)
  }

  validates :bank_account_id, :amount, :status, presence: true
  validates :amount, numericality: true
  validates :bank_account_id, uniqueness: { scope: :tuition_id }

end

# == Schema Information
#
# Table name: receipts
#
#  id         :integer          not null, primary key
#  member_id  :integer
#  amount     :integer
#  method     :string(255)
#  date       :date
#  status     :string(255)
#  debit_id   :integer
#  note       :text
#  created_at :datetime
#  updated_at :datetime
#

class Receipt < ActiveRecord::Base

  METHODS = {
    DEBIT: "0",
    CASH: "1",
  }

  STATUSES = {
    UNPAID: "0",
    PAID: "1",
  }

  belongs_to :member
  belongs_to :debit
  belongs_to :tuition

  default_scope -> {
    order(:tuition_id)
  }

  scope :unpaid, -> {
    where(status: STATUSES[:UNPAID])
  }

  validates :member_id, uniqueness: { scope: :tuition_id }

end

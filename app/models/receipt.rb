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

  scope :debit, -> {
    where(method: METHODS[:DEBIT])
  }

  scope :cash, -> {
    where(method: METHODS[:CASH])
  }

  scope :paid, -> {
    where(status: STATUSES[:PAID])
  }
  scope :unpaid, -> {
    where(status: STATUSES[:UNPAID])
  }

  validates :member_id, uniqueness: { scope: :tuition_id }
  validates :member_id, :amount, :method, :status, presence: true
  validates :amount, numericality: true
  validates :date, presence: true, if: Proc.new { self.status == STATUSES[:PAID] }
  validates :date, absence: true, if: Proc.new { self.status == STATUSES[:UNPAID] }

  def edit?
    self.method == METHODS[:CASH]
  end

end

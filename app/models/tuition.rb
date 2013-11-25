# == Schema Information
#
# Table name: tuitions
#
#  id             :integer          not null, primary key
#  month          :string(255)
#  debit_status   :string(255)
#  note           :text
#  created_at     :datetime
#  updated_at     :datetime
#  receipt_status :string(255)
#

class Tuition < ActiveRecord::Base

  has_many :debits
  has_many :receipts

  DEBIT_STATUSES = {
    IN_PROCESS: "1",
    FINISHED: "2"
  }
  RECEIPT_STATUSES = {
    NONE: "0",
    IN_PROCESS: "1",
    FINISHED: "2"
  }

  default_scope -> { order(:month) }

  validates :month, :debit_status, presence: true
  validates :debit_status, inclusion: { in: DEBIT_STATUSES.map {|k, v| v } }
  validates :month, uniqueness: true

  after_find do
    self.month = self.month[0..3] + "/" + self.month[4..5]
  end

  before_save do
    self.month = self.month.sub("/", "")
  end

  after_save do
    self.month = self.month[0..3] + "/" + self.month[4..5]
  end

  before_destroy do
    self.debits.each do | debit|
      debit.destroy
    end
  end

  def edit?
    debit_status == DEBIT_STATUSES[:IN_PROCESS]
  end

  def fix?
    debit_status == DEBIT_STATUSES[:IN_PROCESS]
  end

  def delete?
    receipt_status == RECEIPT_STATUSES[:NONE]
  end

  private

  def tax_with(amount)
    (amount * 1.05).to_i
  end
end

class Debit < ActiveRecord::Base

  STATUSES = {
    SUCCESS: "1",
    FAILURE: "2",
  }

  belongs_to :bank_account
  has_many :receipts

  validates :bank_account_id, :month, :amount, :status, presence: true
  validates :month, format: { with: /\A201[0-9]\/(01|02|03|04|05|06|07|09|10|11|12)\Z/ }
  validates :amount, numericality: true

  default_scope -> { order(:month) }

  #scope :count_by_month, -> {
  #  unscoped.group(:month).order(:month).count
  #}

end

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

end

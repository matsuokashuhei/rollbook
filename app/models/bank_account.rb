class BankAccount < ActiveRecord::Base
  has_many :members
end

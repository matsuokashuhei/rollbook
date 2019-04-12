class AddFkToBankAccountIdOnMembers < ActiveRecord::Migration[5.1]
  def change
    add_foreign_key :members, :bank_accounts, column: :bank_account_id
  end
end

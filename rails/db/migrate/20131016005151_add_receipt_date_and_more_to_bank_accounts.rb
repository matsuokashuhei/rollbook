class AddReceiptDateAndMoreToBankAccounts < ActiveRecord::Migration[4.2]
  def change
    add_column :bank_accounts, :receipt_date, :date
    add_column :bank_accounts, :ship_date, :date
    add_column :bank_accounts, :begin_date, :date
    add_column :bank_accounts, :self_proceed, :boolean
    add_column :bank_accounts, :change_bank, :boolean
  end
end

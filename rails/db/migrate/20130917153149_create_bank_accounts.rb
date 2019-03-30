class CreateBankAccounts < ActiveRecord::Migration
  def change
    create_table :bank_accounts do |t|
      t.string :holder_name
      t.string :holder_name_kana
      t.string :bank_id
      t.string :bank_name
      t.string :branch_id
      t.string :branch_name
      t.string :account_number
      t.string :status
      t.text :note

      t.timestamps
    end
  end
end

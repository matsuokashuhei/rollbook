class CreateDebits < ActiveRecord::Migration[4.2]
  def change
    create_table :debits do |t|
      t.integer :bank_account_id
      t.string :month
      t.integer :amount
      t.string :status
      t.text :note

      t.timestamps
    end
  end
end

class CreateReceipts < ActiveRecord::Migration
  def change
    create_table :receipts do |t|
      t.integer :member_id
      t.string :month
      t.integer :amount
      t.string :method
      t.date :date
      t.string :status
      t.integer :debit_id
      t.text :note

      t.timestamps
    end
  end
end

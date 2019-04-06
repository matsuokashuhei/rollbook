class DropReceipts < ActiveRecord::Migration[4.2]
  def change
    drop_table :receipts
  end
end

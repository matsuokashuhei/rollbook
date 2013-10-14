class RemoveMonthToReceipts < ActiveRecord::Migration
  def change
    remove_column :receipts, :month
  end
end

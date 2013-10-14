class AddTuitionIdToReceipts < ActiveRecord::Migration
  def change
    add_column :receipts, :tuition_id, :integer
  end
end

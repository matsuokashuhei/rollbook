class AddReceiptStatusToTuitions < ActiveRecord::Migration
  def change
    add_column :tuitions, :receipt_status, :string
  end
end

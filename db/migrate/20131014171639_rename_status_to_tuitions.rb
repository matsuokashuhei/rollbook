class RenameStatusToTuitions < ActiveRecord::Migration
  def change
    rename_column :tuitions, :status, :debit_status
  end
end

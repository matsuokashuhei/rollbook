class AddTuitionIdToDebits < ActiveRecord::Migration
  def change
    add_column :debits, :tuition_id, :integer
  end
end

class RemoveMonthToDebits < ActiveRecord::Migration
  def change
    remove_column :debits, :month
  end
end

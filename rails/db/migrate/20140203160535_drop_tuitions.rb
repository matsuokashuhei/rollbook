class DropTuitions < ActiveRecord::Migration[4.2]
  def change
    drop_table :tuitions
  end
end

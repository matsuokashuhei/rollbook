class DropDebits < ActiveRecord::Migration
  def change
    drop_table :debits
  end
end

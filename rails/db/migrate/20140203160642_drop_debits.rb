class DropDebits < ActiveRecord::Migration[4.2]
  def change
    drop_table :debits
  end
end

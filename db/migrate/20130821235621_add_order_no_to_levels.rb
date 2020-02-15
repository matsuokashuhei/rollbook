class AddOrderNoToLevels < ActiveRecord::Migration[4.2]
  def change
    add_column :levels, :order_no, :integer
  end
end

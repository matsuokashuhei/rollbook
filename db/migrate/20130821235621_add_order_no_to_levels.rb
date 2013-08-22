class AddOrderNoToLevels < ActiveRecord::Migration
  def change
    add_column :levels, :order_no, :integer
  end
end

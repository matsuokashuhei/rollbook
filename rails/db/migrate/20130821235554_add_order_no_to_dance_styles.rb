class AddOrderNoToDanceStyles < ActiveRecord::Migration
  def change
    add_column :dance_styles, :order_no, :integer
  end
end

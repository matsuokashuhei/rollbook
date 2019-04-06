class AddOrderNoToDanceStyles < ActiveRecord::Migration[4.2]
  def change
    add_column :dance_styles, :order_no, :integer
  end
end

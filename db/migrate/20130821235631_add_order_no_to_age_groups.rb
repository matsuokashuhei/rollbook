class AddOrderNoToAgeGroups < ActiveRecord::Migration[4.2]
  def change
    add_column :age_groups, :order_no, :integer
  end
end

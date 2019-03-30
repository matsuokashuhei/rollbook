class AddOrderNoToAgeGroups < ActiveRecord::Migration
  def change
    add_column :age_groups, :order_no, :integer
  end
end

class AddNoToMembers < ActiveRecord::Migration
  def change
    add_column :members, :no, :string
  end
end

class AddNoToMembers < ActiveRecord::Migration[4.2]
  def change
    add_column :members, :no, :string
  end
end

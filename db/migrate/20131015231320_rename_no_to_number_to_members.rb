class RenameNoToNumberToMembers < ActiveRecord::Migration[4.2]
  def change
    rename_column :members, :no, :number
  end
end

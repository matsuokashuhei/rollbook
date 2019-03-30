class RenameNoToNumberToMembers < ActiveRecord::Migration
  def change
    rename_column :members, :no, :number
  end
end

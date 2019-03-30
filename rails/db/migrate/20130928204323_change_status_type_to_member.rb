class ChangeStatusTypeToMember < ActiveRecord::Migration
  def change
    change_column :members, :status, :string
  end
end

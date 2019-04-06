class ChangeStatusTypeToMember < ActiveRecord::Migration[4.2]
  def change
    change_column :members, :status, :string
  end
end

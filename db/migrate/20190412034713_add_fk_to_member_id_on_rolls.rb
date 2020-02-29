class AddFkToMemberIdOnRolls < ActiveRecord::Migration[5.1]
  def change
    add_foreign_key :rolls, :members, column: :member_id
  end
end

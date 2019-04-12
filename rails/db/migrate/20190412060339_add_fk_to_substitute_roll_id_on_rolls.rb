class AddFkToSubstituteRollIdOnRolls < ActiveRecord::Migration[5.1]
  def change
    add_foreign_key :rolls, :rolls, column: :substitute_roll_id
  end
end

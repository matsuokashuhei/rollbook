class AddFkToLessonIdOnRolls < ActiveRecord::Migration[5.1]
  def change
    add_foreign_key :rolls, :lessons, column: :lesson_id
  end
end

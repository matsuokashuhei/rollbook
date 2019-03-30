class AddIndexToRollsLessonId < ActiveRecord::Migration[4.2]
  def change
    add_index :rolls, :lesson_id
  end
end

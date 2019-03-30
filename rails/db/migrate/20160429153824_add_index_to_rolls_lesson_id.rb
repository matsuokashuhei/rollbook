class AddIndexToRollsLessonId < ActiveRecord::Migration
  def change
    add_index :rolls, :lesson_id
  end
end

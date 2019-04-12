class AddFkToLevelIdOnCourses < ActiveRecord::Migration[5.1]
  def change
    add_foreign_key :courses, :levels, column: :level_id
  end
end

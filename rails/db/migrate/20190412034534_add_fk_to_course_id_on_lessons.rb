class AddFkToCourseIdOnLessons < ActiveRecord::Migration[5.1]
  def change
    add_foreign_key :lessons, :courses, column: :course_id
  end
end

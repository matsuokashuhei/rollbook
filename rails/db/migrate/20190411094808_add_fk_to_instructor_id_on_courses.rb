class AddFkToInstructorIdOnCourses < ActiveRecord::Migration[5.1]
  def change
    add_foreign_key :courses, :instructors, column: :instructor_id
  end
end

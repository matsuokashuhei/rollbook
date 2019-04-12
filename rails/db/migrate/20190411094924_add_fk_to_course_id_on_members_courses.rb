class AddFkToCourseIdOnMembersCourses < ActiveRecord::Migration[5.1]
  def change
    add_foreign_key :members_courses, :courses, column: :course_id
  end
end

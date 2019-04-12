class AddFkToMembersCourseIdOnRecesses < ActiveRecord::Migration[5.1]
  def change
    add_foreign_key :recesses, :members_courses, column: :members_course_id
  end
end

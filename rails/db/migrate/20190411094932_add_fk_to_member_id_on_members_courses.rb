class AddFkToMemberIdOnMembersCourses < ActiveRecord::Migration[5.1]
  def change
    add_foreign_key :members_courses, :members, column: :member_id
  end
end

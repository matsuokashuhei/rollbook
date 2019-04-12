class AddFkToAgeGroupIdOnCourses < ActiveRecord::Migration[5.1]
  def change
    add_foreign_key :courses, :age_groups, column: :age_group_id
  end
end

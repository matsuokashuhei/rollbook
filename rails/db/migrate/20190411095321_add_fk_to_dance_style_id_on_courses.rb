class AddFkToDanceStyleIdOnCourses < ActiveRecord::Migration[5.1]
  def change
    add_foreign_key :courses, :dance_styles, column: :dance_style_id
  end
end

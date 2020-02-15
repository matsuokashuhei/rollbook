class AddFkToTimetableIdOnCourses < ActiveRecord::Migration[5.1]
  def change
    add_foreign_key :courses, :timetables, column: :timetable_id
  end
end

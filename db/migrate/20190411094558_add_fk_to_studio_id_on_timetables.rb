class AddFkToStudioIdOnTimetables < ActiveRecord::Migration[5.1]
  def change
    add_foreign_key :timetables, :studios, column: :studio_id
  end
end

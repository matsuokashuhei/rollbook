class RenameCwdayToTimetables < ActiveRecord::Migration[4.2]
  def change
    rename_column :timetables, :cwday, :weekday
  end
end

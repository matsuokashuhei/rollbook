class RenameCwdayToTimetables < ActiveRecord::Migration
  def change
    rename_column :timetables, :cwday, :weekday
  end
end

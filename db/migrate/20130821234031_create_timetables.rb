class CreateTimetables < ActiveRecord::Migration
  def change
    create_table :timetables do |t|
      t.integer :studio_id
      t.integer :cwday
      t.integer :time_slot_id

      t.timestamps
    end
  end
end

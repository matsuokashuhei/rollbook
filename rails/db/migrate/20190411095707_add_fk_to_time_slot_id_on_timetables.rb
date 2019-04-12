class AddFkToTimeSlotIdOnTimetables < ActiveRecord::Migration[5.1]
  def change
    add_foreign_key :timetables, :time_slots, column: :time_slot_id
  end
end

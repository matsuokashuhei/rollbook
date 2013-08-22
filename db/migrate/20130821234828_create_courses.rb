class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.integer :timetable_id
      t.integer :instructor_id
      t.integer :dance_style_id
      t.integer :level_id
      t.integer :age_group_id
      t.date :open_date
      t.date :close_date
      t.text :note
      t.integer :monthly_fee

      t.timestamps
    end
  end
end

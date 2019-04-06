class CreateLessons < ActiveRecord::Migration[4.2]
  def change
    create_table :lessons do |t|
      t.integer :course_id
      t.date :date
      t.string :status
      t.text :note

      t.timestamps
    end
  end
end

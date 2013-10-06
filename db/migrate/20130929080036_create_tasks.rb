class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :name
      t.string :frequency
      t.date :due_date
      t.string :status
      t.text :note

      t.timestamps
    end
  end
end

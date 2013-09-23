class CreateRecesses < ActiveRecord::Migration
  def change
    create_table :recesses do |t|
      t.integer :members_course_id
      t.string :month
      t.string :status
      t.text :note

      t.timestamps
    end
  end
end

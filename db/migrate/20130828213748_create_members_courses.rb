class CreateMembersCourses < ActiveRecord::Migration
  def change
    create_table :members_courses do |t|
      t.integer :member_id
      t.integer :course_id
      t.date :begin_date
      t.date :end_date
      t.text :note
      t.boolean :introduction

      t.timestamps
    end
  end
end

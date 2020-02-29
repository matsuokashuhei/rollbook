class AddSubsitutableToMembersCourses < ActiveRecord::Migration[4.2]
  def change
    add_column :members_courses, :substitutable, :boolean, null: false, default: true
  end
end

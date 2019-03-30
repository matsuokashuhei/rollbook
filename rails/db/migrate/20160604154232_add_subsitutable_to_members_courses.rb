class AddSubsitutableToMembersCourses < ActiveRecord::Migration
  def change
    add_column :members_courses, :substitutable, :boolean, null: false, default: true
  end
end

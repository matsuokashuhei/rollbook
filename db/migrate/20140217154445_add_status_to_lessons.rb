class AddStatusToLessons < ActiveRecord::Migration
  def change
    add_column :lessons, :status, :string
  end
end

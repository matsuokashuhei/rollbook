class AddStatusToLessons < ActiveRecord::Migration[4.2]
  def change
    add_column :lessons, :status, :string
  end
end

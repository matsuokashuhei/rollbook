class RenameStatusToRollsStatusToLessons < ActiveRecord::Migration[4.2]
  def change
    rename_column :lessons, :status, :rolls_status
  end
end

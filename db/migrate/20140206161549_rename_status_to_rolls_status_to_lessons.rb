class RenameStatusToRollsStatusToLessons < ActiveRecord::Migration
  def change
    rename_column :lessons, :status, :rolls_status
  end
end

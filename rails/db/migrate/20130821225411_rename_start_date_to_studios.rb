class RenameStartDateToStudios < ActiveRecord::Migration
  def change
    rename_column :studios, :start_date, :open_date
  end
end

class RenameStartDateToStudios < ActiveRecord::Migration[4.2]
  def change
    rename_column :studios, :start_date, :open_date
  end
end

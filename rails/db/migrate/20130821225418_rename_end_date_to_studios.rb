class RenameEndDateToStudios < ActiveRecord::Migration[4.2]
  def change
    rename_column :studios, :end_date, :close_date
  end
end

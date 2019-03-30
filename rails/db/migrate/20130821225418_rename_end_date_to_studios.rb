class RenameEndDateToStudios < ActiveRecord::Migration
  def change
    rename_column :studios, :end_date, :close_date
  end
end

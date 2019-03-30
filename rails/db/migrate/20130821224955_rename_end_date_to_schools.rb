class RenameEndDateToSchools < ActiveRecord::Migration
  def change
    rename_column :schools, :end_date, :close_date
  end
end

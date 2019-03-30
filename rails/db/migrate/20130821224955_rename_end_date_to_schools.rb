class RenameEndDateToSchools < ActiveRecord::Migration[4.2]
  def change
    rename_column :schools, :end_date, :close_date
  end
end

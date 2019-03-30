class RenameStartDateToSchools < ActiveRecord::Migration
  def change
    rename_column :schools, :start_date, :open_date
  end
end

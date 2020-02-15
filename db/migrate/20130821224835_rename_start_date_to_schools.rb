class RenameStartDateToSchools < ActiveRecord::Migration[4.2]
  def change
    rename_column :schools, :start_date, :open_date
  end
end

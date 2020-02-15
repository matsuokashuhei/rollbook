class AddStartDateToSchools < ActiveRecord::Migration[4.2]
  def change
    add_column :schools, :start_date, :date
  end
end

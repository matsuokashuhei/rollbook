class AddStartDateToSchools < ActiveRecord::Migration
  def change
    add_column :schools, :start_date, :date
  end
end

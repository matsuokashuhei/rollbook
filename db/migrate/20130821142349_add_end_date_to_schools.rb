class AddEndDateToSchools < ActiveRecord::Migration
  def change
    add_column :schools, :end_date, :date
  end
end

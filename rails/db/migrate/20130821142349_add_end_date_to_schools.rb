class AddEndDateToSchools < ActiveRecord::Migration[4.2]
  def change
    add_column :schools, :end_date, :date
  end
end

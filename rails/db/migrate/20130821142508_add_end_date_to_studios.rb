class AddEndDateToStudios < ActiveRecord::Migration[4.2]
  def change
    add_column :studios, :end_date, :date
  end
end

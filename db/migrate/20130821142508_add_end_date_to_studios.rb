class AddEndDateToStudios < ActiveRecord::Migration
  def change
    add_column :studios, :end_date, :date
  end
end

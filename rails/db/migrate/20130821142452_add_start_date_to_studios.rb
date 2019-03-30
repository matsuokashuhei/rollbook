class AddStartDateToStudios < ActiveRecord::Migration
  def change
    add_column :studios, :start_date, :date
  end
end

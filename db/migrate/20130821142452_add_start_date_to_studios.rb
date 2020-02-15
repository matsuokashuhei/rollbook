class AddStartDateToStudios < ActiveRecord::Migration[4.2]
  def change
    add_column :studios, :start_date, :date
  end
end

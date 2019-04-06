class CreateHolidays < ActiveRecord::Migration[4.2]
  def change
    create_table :holidays do |t|
      t.date :date

      t.timestamps
    end
  end
end

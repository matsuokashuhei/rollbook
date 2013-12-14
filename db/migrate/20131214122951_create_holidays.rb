class CreateHolidays < ActiveRecord::Migration
  def change
    create_table :holidays do |t|
      t.date :date

      t.timestamps
    end
  end
end

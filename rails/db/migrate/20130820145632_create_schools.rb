class CreateSchools < ActiveRecord::Migration[4.2]
  def change
    create_table :schools do |t|
      t.string :name
      t.string :zip
      t.string :address
      t.string :phone
      t.text :note

      t.timestamps
    end
  end
end

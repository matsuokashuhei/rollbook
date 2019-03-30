class CreateStudios < ActiveRecord::Migration[4.2]
  def change
    create_table :studios do |t|
      t.string :name
      t.string :note
      t.integer :school_id

      t.timestamps
    end
  end
end

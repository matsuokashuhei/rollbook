class CreateTuitions < ActiveRecord::Migration[4.2]
  def change
    create_table :tuitions do |t|
      t.string :month
      t.string :status
      t.text :note

      t.timestamps
    end
  end
end

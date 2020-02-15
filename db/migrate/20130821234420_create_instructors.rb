class CreateInstructors < ActiveRecord::Migration[4.2]
  def change
    create_table :instructors do |t|
      t.string :name
      t.string :kana
      t.string :team
      t.string :phone
      t.string :email_pc
      t.string :email_mobile
      t.text :note

      t.timestamps
    end
  end
end

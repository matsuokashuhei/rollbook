class CreateMembers < ActiveRecord::Migration
  def change
    create_table :members do |t|
      t.string :first_name
      t.string :last_name
      t.string :first_name_kana
      t.string :last_name_kana
      t.string :gender
      t.date :birth_date
      t.string :zip
      t.string :address
      t.string :phone
      t.string :email_pc
      t.string :email_mobile
      t.text :note
      t.date :enter_date
      t.date :leave_date
      t.integer :bank_account_id
      t.integer :status
      t.string :nearby_station

      t.timestamps
    end
  end
end

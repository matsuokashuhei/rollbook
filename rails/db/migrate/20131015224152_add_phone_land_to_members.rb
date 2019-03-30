class AddPhoneLandToMembers < ActiveRecord::Migration[4.2]
  def change
    add_column :members, :phone_land, :string
  end
end

class AddPhoneLandToMembers < ActiveRecord::Migration
  def change
    add_column :members, :phone_land, :string
  end
end

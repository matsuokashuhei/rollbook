class RenamePhoneToPhoneMobileToMembers < ActiveRecord::Migration[4.2]
  def change
    rename_column :members, :phone, :phone_mobile
  end
end

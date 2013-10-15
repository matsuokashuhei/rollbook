class RenamePhoneToPhoneMobileToMembers < ActiveRecord::Migration
  def change
    rename_column :members, :phone, :phone_mobile
  end
end

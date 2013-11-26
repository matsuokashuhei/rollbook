class RenameSelfProceedToImperfectToBankAccounts < ActiveRecord::Migration
  def change
    rename_column :bank_accounts, :self_proceed, :imperfect
  end
end

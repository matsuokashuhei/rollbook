class RenameSelfProceedToImperfectToBankAccounts < ActiveRecord::Migration[4.2]
  def change
    rename_column :bank_accounts, :self_proceed, :imperfect
  end
end

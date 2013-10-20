module BankAccountsHelper

  def bank_accounts_link
    link_to t("activerecord.models.bank_account"), bank_accounts_path
  end

end

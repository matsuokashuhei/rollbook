module BankAccountsHelper

  # タブ用
  def tab_to_bank_account bank_account, active: false
    text = t "activerecord.models.bank_account"
    if active
      content_tag :li, class: "active" do
        link_to text, '#bank_account', data: { toggle: "tab" }
      end
    else
      content_tag :li do
        link_to text, bank_account_path(bank_account)
      end
    end
  end

  def tab_to_bank_account_members bank_account, active: false
    text = t "activerecord.models.member"
    if active
      content_tag :li, class: "active" do
        link_to text, '#members', data: { toggle: "tab" }
      end
    else
      content_tag :li do
        link_to text, bank_account_members_path(bank_account)
      end
    end
  end

  private

  def link_to_bank_accounts
    link_to t("activerecord.models.bank_account"), bank_accounts_path
  end

  def link_to_bank_account bank_account
    link_to bank_account.holder_name, bank_account_path(bank_account)
  end
end

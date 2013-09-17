module BankAccountsHelper

  def display_name(bank_account)
    <<-"EOS".strip_heredoc.html_safe
    <small>#{bank_account.holder_name_kana}</small><br />
    #{bank_account.holder_name}
    EOS
    #"<small>#{bank_account.holder_name_kana}</small><br />#{bank_account.holder_name}".html_safe
  end

end

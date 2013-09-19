module BankAccountsHelper

  STATUS = {
    "0" => "未登録",
    "1" => "手続き中",
    "2" => "登録済み",
    "3" => "手続き失敗",
    "4" => "マスター削除中",
    "5" => "マスター削除済"
  }

  def display_name(bank_account)
    <<-"EOS".strip_heredoc.html_safe
    <small>#{bank_account.holder_name_kana}</small><br />
    #{bank_account.holder_name}
    EOS
    #"<small>#{bank_account.holder_name_kana}</small><br />#{bank_account.holder_name}".html_safe
  end

  def status_name(status)
    STATUS[status]
  end

  def statuses
    STATUS
  end

end

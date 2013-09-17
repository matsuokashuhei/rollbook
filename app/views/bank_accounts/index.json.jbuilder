json.array!(@bank_accounts) do |bank_account|
  json.extract! bank_account, :holder_name, :holder_name_kana, :bank_id, :bank_name, :branch_id, :branch_name, :account_number, :status, :note
  json.url bank_account_url(bank_account, format: :json)
end

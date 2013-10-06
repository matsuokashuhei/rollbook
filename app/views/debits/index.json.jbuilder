json.array!(@debits) do |debit|
  json.extract! debit, :bank_account_id, :month, :, :status, :note
  json.url debit_url(debit, format: :json)
end

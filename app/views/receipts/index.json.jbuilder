json.array!(@receipts) do |receipt|
  json.extract! receipt, :member_id, :month, :amount, :method, :date, :status, :debit_id, :note
  json.url receipt_url(receipt, format: :json)
end

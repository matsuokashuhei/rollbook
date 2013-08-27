json.array!(@members) do |member|
  json.extract! member, :first_name, :last_name, :first_name_kana, :last_name_kana, :gender, :birth_date, :zip, :address, :phone, :email_pc, :email_mobile, :note, :enter_date, :leave_date, :bank_account_id, :status, :nearby_station
  json.url member_url(member, format: :json)
end

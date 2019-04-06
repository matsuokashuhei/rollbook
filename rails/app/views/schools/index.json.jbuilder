json.array!(@schools) do |school|
  json.extract! school, :name, :zip, :address, :phone, :note
  json.url school_url(school, format: :json)
end

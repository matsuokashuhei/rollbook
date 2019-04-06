json.array!(@levels) do |level|
  json.extract! level, :name
  json.url level_url(level, format: :json)
end

json.array!(@age_groups) do |age_group|
  json.extract! age_group, :name
  json.url age_group_url(age_group, format: :json)
end

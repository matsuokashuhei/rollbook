json.array!(@posts) do |post|
  json.extract! post, :id, :title, :content, :user_id, :open_date, :close_date
  json.url post_url(post, format: :json)
end

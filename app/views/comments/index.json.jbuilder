json.array!(@comments) do |comment|
  json.extract! comment, :id, :post_id, :content, :user_id
  json.url comment_url(comment, format: :json)
end

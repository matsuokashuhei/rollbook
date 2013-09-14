json.array!(@rolls) do |roll|
  json.extract! roll, :lesson_id, :member_id, :status, :substitute_roll_id
  json.url roll_url(roll, format: :json)
end

json.array!(@recesses) do |recess|
  json.extract! recess, :members_course_id, :month, :status, :note
  json.url recess_url(recess, format: :json)
end

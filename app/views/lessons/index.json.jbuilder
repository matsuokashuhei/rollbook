json.array!(@lessons) do |lesson|
  json.extract! lesson, :course_id, :date, :status, :note
  json.url lesson_url(lesson, format: :json)
end

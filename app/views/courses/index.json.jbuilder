json.array!(@courses) do |course|
  json.extract! course, :timetable_id, :instructor_id, :dance_style_id, :level_id, :age_group_id, :open_date, :close_date, :note, :monthly_fee
  json.url course_url(course, format: :json)
end

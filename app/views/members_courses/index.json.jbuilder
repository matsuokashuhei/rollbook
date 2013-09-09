json.array!(@members_courses) do |members_course|
  json.extract! members_course, :member_id, :course_id, :begin_date, :end_date, :note, :introduction
  json.url members_course_url(members_course, format: :json)
end

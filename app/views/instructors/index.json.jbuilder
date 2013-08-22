json.array!(@instructors) do |instructor|
  json.extract! instructor, :name, :kana, :team, :phone, :email_pc, :email_mobile, :note
  json.url instructor_url(instructor, format: :json)
end

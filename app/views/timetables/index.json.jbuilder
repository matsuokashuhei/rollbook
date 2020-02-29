json.array!(@timetables) do |timetable|
  json.extract! timetable, :studio_id, :cwday, :time_slot_id
  json.url timetable_url(timetable, format: :json)
end

json.array!(@tuitions) do |tuition|
  json.extract! tuition, :month, :status, :note
  json.url tuition_url(tuition, format: :json)
end

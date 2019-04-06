json.array!(@studios) do |studio|
  json.extract! studio, :name, :note, :school_id
  json.url studio_url(studio, format: :json)
end

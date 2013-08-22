json.array!(@dance_styles) do |dance_style|
  json.extract! dance_style, :name
  json.url dance_style_url(dance_style, format: :json)
end

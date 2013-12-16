json.array!(@series) do |show|
  json.extract! series, :id, :name, :poster
  json.url show_url(series, format: :json)
end

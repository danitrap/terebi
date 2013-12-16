json.array!(@shows) do |show|
  json.extract! show, :id, :name, :poster
  json.url show_url(show, format: :json)
end

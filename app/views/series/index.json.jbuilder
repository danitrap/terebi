json.array!(@series) do |series|
  json.extract! series, :id, :name, :overview, :poster, :imdb_id
  json.url series_episodes_url(series, format: :json)
end

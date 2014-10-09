json.array!(@series) do |series|
  json.extract! series, :id, :name, :overview, :cached_poster, :imdb_id
  json.json_url series_episodes_url(series, format: :json)
  json.url series_episodes_url(series)
end

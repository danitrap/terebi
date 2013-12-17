json.array!(@episodes) do |episode|
  json.extract! episode, :id, :name, :season, :episode, :overview, :air_date, :thumb, :path
  json.url play_series_episode_url(@series, episode)
end

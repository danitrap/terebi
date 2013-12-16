json.array!(@episodes) do |episode|
  json.extract! episode, :id, :name, :number, :path, :show_id
  json.url episode_url(episode, format: :json)
end

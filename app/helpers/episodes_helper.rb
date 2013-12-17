module EpisodesHelper
  def episode_meta(episode)
    season = "%02d" % episode.season
    ep = "%02d" % episode.episode
    "S#{season}E#{ep}"
  end
end

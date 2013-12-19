require 'pathname'
class Episode < ActiveRecord::Base
  belongs_to :series, touch: true

  has_attached_file :cached_thumb

  attr_reader :remote_thumb

  validates :name, presence: true
  validates :path, presence: true, uniqueness: true

  @tvdb ||= TvdbParty::Search.new("C62F24B5D73BAFE2", "en")

  def meta
    season = "%02d" % self.season
    ep = "%02d" % self.episode
    "S#{season}E#{ep}"
  end

  def remote_thumb=(url)
    self.cached_thumb = URI.parse(url)
    @remote_thumb = url
  end

  def self.add(video_path)
    video_dir = Pathname.new(video_path.gsub("\\", "/"))
    video = video_dir.directory? ? video_dir.children.select {|v| File.extname(v) == ".mkv" || File.extname(v) == ".mp4"}.first : video_dir.to_s
    return nil if video.to_s.include?("sample")
    return nil if Episode.exists? path: video.to_s
    file = Path.new(video)
    episodio = Suby::FilenameParser.parse(file)
    results = @tvdb.search(episodio[:show]).first rescue nil
    series_metadata = results && @tvdb.get_series_by_id(results["seriesid"]) rescue nil
    tvdb_ep = series_metadata && series_metadata.get_episode(episodio[:season], episodio[:episode]) rescue nil
    if tvdb_ep.nil?
      tvdb_ep = TvdbMocker.new(episodio[:name], "No overview.", "http://placehold.it/350x250", Time.now)
    end
    series_name = series_metadata.name || "Unknown"
    series = Series.where(:name => series_name).take || Series.add(series_name)
    series.episodes.where(:name => tvdb_ep.name).first_or_create.tap do |e|
      e.overview = tvdb_ep.overview
      e.remote_thumb = tvdb_ep.thumb
      e.air_date = tvdb_ep.air_date
      e.episode = episodio[:episode] || 0
      e.season = episodio[:season] || 0
      e.path = video.to_s
      e.save!
    end
    puts "#{series_metadata.name} - #{tvdb_ep.name} added."
  end

  def self.update_episodes
    media_path = APP_CONFIG['media_path']
    videos = Dir["#{media_path}/**/*.mkv"].to_a | Dir["#{media_path}/**/*.mp4"].to_a

    videos.each do |episode|
      Episode.add(episode)
    end

    SubtitlesChecker.check!
  end
end

class Episode < ActiveRecord::Base

  scope :seen, -> { where(:seen => true).order("updated_at DESC").limit(10) }
  scope :unseen, -> { where(:seen => false).order("air_date DESC") }

  belongs_to :series, touch: true

  has_attached_file :cached_thumb

  validates :name, presence: true
  validates :path, presence: true, uniqueness: true

  @tvdb ||= TvdbParty::Search.new("C62F24B5D73BAFE2", "en")

  def to_param
    "#{id} #{name}".parameterize
  end

  def meta
    season = "%02d" % self.season
    ep = "%02d" % self.episode
    "S#{season}E#{ep}"
  end

  def remote_thumb=(url)
    self.cached_thumb = URI.parse(url)
    self.thumb = url
  end

  def remote_thumb
    self.thumb
  end

  def self.add(video_path)
    video = video_path.gsub("\\", "/")

    return nil if video =~ /sample.{4}\z/
    return Episode.where(:path => video).take if Episode.exists? path: video

    file = Path.new(video)
    episodio = Suby::FilenameParser.parse(file)
    results = @tvdb.search(episodio[:show]).first rescue nil
    series_metadata = results && @tvdb.get_series_by_id(results["seriesid"]) rescue nil
    tvdb_ep = series_metadata && series_metadata.get_episode(episodio[:season], episodio[:episode]) rescue nil
    
    if tvdb_ep.nil?
      tvdb_ep = TvdbMocker.new(episodio[:name] || "Untitled", "No overview.", "http://placehold.it/400x225", Time.now)
    end

    if series_metadata
      series_name = series_metadata.name
    else
      series_name = "Unknown Series"
    end
    
    series = Series.where(:name => series_name).take || Series.add(series_name)
    saved = series.episodes.where(:name => tvdb_ep.name).first_or_create.tap do |e|
      e.overview = tvdb_ep.overview
      e.remote_thumb = tvdb_ep.thumb || "http://placehold.it/400x225"
      e.air_date = tvdb_ep.air_date
      e.episode = episodio[:episode] || 0
      e.season = episodio[:season] || 0
      e.path = video
      e.save!
    end
    logger.info "#{saved.series.name} - #{tvdb_ep.name} added."
    saved
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

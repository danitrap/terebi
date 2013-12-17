require 'pathname'
class Episode < ActiveRecord::Base
  belongs_to :series, touch: true

  validates :name, presence: true
  validates :path, presence: true, uniqueness: true

  @tvdb ||= TvdbParty::Search.new("C62F24B5D73BAFE2", "it")

  def meta
    season = "%02d" % self.season
    ep = "%02d" % self.episode
    "S#{season}E#{ep}"
  end

  def self.add(video_path)

    video_dir = Pathname.new(video_path)
    video = video_dir.directory? ? video_dir.children.select {|v| File.extname(v) == ".mkv" || File.extname(v) == ".mp4"}.first : video_dir.to_s
    return nil if video.include?("sample")
    return nil if Episode.exists? path: video
    file = FileMocker.new(File.basename(video))
    episodio = Suby::FilenameParser.parse(file)
    p episodio
    results = @tvdb.search(episodio[:show]).first rescue nil
    result = results && @tvdb.get_series_by_id(results["seriesid"]) rescue nil
    tvdb_ep = result && result.get_episode(episodio[:season], episodio[:episode]) rescue nil
    if tvdb_ep.nil?
      tvdb_ep = TvdbMocker.new(episodio[:name], "No overview.", "http://placehold.it/350x250", Time.now)
    end
    series_name = episodio[:show] || "Unknown"
    series = Series.where("name LIKE ?", "%#{series_name}%").take || Series.add(series_name)
    if series
      saved = series.episodes.where(:name => tvdb_ep.name).first_or_create.tap do |e|
        e.overview = tvdb_ep.overview
        e.thumb = tvdb_ep.thumb
        e.air_date = tvdb_ep.air_date
        e.episode = episodio[:episode] || 0
        e.season = episodio[:season] || 0
        e.path = video.to_s
        e.save!
      end
      p saved
    end
  end
end

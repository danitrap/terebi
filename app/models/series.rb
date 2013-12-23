require 'pathname'
class Series < ActiveRecord::Base
  has_many :episodes, dependent: :destroy

  has_attached_file :cached_poster
  has_attached_file :cached_banner

  validates :name, presence: true, uniqueness: true

  @tvdb ||= TvdbParty::Search.new("C62F24B5D73BAFE2", "en")

  def to_param
    "#{id} #{name}".parameterize
  end

  def remote_poster=(url)
    self.cached_poster = URI.parse(url)
    self.poster = url
  end

  def remote_poster
    self.poster
  end

  def remote_banner=(url)
    self.cached_banner = URI.parse(url)
    self.banner = url
  end

  def remote_banner
    self.banner
  end


  def self.add(show)
    @series_name = show
    get_series_metadata

    logger.info "#{@series_metadata.name} in creation."

    Series.where(:name => @series_metadata.name).first_or_create.tap do |serie|
      serie.name = @series_metadata.name
      serie.overview = @series_metadata.overview
      serie.remote_banner = @series_metadata.series_banners('en').first.url
      serie.remote_poster = @series_metadata.posters('en').first.url
      serie.imdb_id = @series_metadata.imdb_id
      serie.save!
    end
  end

  def self.get_series_metadata
    results = @tvdb.search(@series_name).first rescue nil
    @series_metadata = @tvdb.get_series_by_id(results["seriesid"]) rescue nil
    if @series_metadata.nil? 
      @series_metadata = TvdbSeriesMocker.new("Unknown", "Unknown series.", "http://placehold.it/350x50",
             "http://placehold.it/680x1000", "none")
    end
  end
  private_class_method :get_series_metadata
  
end

require 'pathname'
class Series < ActiveRecord::Base
  has_many :episodes, dependent: :destroy

  validates :name, presence: true, uniqueness: true

  @tvdb ||= TvdbParty::Search.new("C62F24B5D73BAFE2", APP_CONFIG['subs_locale'])

  def self.add(show)
    @series_name = File.basename(show)
    get_series_metadata

    Series.where(:name => @series_metadata.name).first_or_create.tap do |serie|
      serie.name = @series_metadata.name
      serie.overview = @series_metadata.overview
      serie.banner = @series_metadata.series_banners('en').first.url
      serie.poster = @series_metadata.posters('en').first.url
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
end

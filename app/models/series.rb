require 'pathname'
class Series < ActiveRecord::Base
  has_many :episodes, dependent: :destroy

  validates :name, presence: true, uniqueness: true

  @tvdb ||= TvdbParty::Search.new("C62F24B5D73BAFE2", "it")

  def self.add(show)
    name = File.basename(show)
    results = @tvdb.search(name).first rescue nil
    result = @tvdb.get_series_by_id(results["seriesid"]) rescue nil
    if result.nil? 
      result = TvdbSeriesMocker.new("Unknown", "Unknown series.", "http://placehold.it/350x50",
               "http://placehold.it/227x335", "none")
    end

    saved = Series.where(:name => result.name).first_or_create.tap do |serie|
      serie.name = name
      serie.overview = result.overview
      serie.banner = result.series_banners('en').first.url
      serie.poster = result.posters('en').first.url
      serie.imdb_id = result.imdb_id
      serie.save!
    end
    p saved
    return saved
  end
end

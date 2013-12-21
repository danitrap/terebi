class TvdbSeriesMocker < Struct.new(:name, :overview, :banner, :poster, :imdb_id)
  def series_banners(lang)
    [Struct.new(:url).new(banner)]
  end
  def posters(lang)
    [Struct.new(:url).new(poster)]
  end
end
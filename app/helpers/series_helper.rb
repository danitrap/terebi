module SeriesHelper
  
  def poster_link(series)
    link_to image_tag(series.cached_poster, class: "img-responsive series-poster", alt: series.name), series_episodes_path(series)
  end
end

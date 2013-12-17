namespace :terebi do
  desc "seed series"
  task seed_series: :environment do
    require 'pathname'
    directories = Pathname.new("F:\\TV Shows\\").children.select { |f| f.directory? }
    tvdb = TvdbParty::Search.new("C62F24B5D73BAFE2", "it")

    directories.each do |show|
      name = File.basename(show)
      results = tvdb.search(name).select {|s| s["language"] == "en"}.first rescue next
      result = tvdb.get_series_by_id(results["seriesid"]) rescue next
      saved = Series.where(:name => name).first_or_create.tap do |serie|
        serie.name = name
        serie.overview = result.overview
        serie.banner = result.series_banners('en').first.url
        serie.poster = result.posters('en').first.url
        serie.imdb_id = result.imdb_id
        serie.save!
      end
      p saved
      sleep 1
    end
  end

  desc "seed episodes"
  task seed_episodes: :environment do
    directories = Pathname.new("F:\\TV Shows\\").children.select { |f| f.directory? }
    tvdb = TvdbParty::Search.new("C62F24B5D73BAFE2", "it")

    directories.each do |show|
      name = File.basename(show)
      puts "lavorando con #{name}"
      results = tvdb.search(name).select {|s| s["language"] == "en"}.first rescue next
      result = tvdb.get_series_by_id(results["seriesid"]) rescue next

      series = Series.where(:name => name).take
      episodes = show.children.select { |f| f.directory? }

      episodes.each do |episode|
        Episode.add(episode)
      end
    sleep 1
    end
  end

  desc "add episode"
  task :add_episode, [:video] => [:environment] do |t, args|
    Episode.add(args[:video])
  end
end  

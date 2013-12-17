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
    FileMocker = Struct.new(:basename)

    directories.each do |show|
      name = File.basename(show)
      puts "lavorando con #{name}"
      results = tvdb.search(name).select {|s| s["language"] == "en"}.first rescue next
      result = tvdb.get_series_by_id(results["seriesid"]) rescue next

      series = Series.where(:name => name).take
      episodes = show.children.select { |f| f.directory? }

      episodes.each do |episode|
        video_fp = episode.children.select { |v| File.extname(v) == ".mkv" }.first
        video = File.basename(video_fp)
        file = FileMocker.new(File.basename(video))
        episodio = Suby::FilenameParser.parse(file)

        next if episodio[:type] == :unknown

        tvdb_ep = result.get_episode(episodio[:season], episodio[:episode])
        puts "#{name} S#{episodio[:season]}E#{episodio[:episode]}"

        saved = series.episodes.where(:name => tvdb_ep.name).first_or_create.tap do |e|
          e.overview = tvdb_ep.overview
          e.thumb = tvdb_ep.thumb
          e.air_date = tvdb_ep.air_date
          e.episode = tvdb_ep.number.to_i
          e.season = tvdb_ep.season_number.to_i
          e.path = video_fp.to_s
          e.save!
        end
        p saved
        sleep 1
      end
    sleep 1
    end
  end

  desc "add episode"
  task :add_episode, [:video] => [:environment] do |t, args|
    tvdb = TvdbParty::Search.new("C62F24B5D73BAFE2", "it")
    FileMocker = Struct.new(:basename)
    video_dir = args[:video]
    video = Pathname.new(video_dir).children.select {|v| File.extname(v) == ".mkv" || File.extname(v) == ".mp4"}.first
    file = FileMocker.new(File.basename(video))
    episodio = Suby::FilenameParser.parse(file)
    next if episodio[:type] == :unknown
    p episodio
    results = tvdb.search(episodio[:show]).first rescue next
    result = tvdb.get_series_by_id(results["seriesid"]) rescue next
    tvdb_ep = result.get_episode(episodio[:season], episodio[:episode])
    series = Series.where("name LIKE ?", "%#{episodio[:show]}%").take
    if series
      saved = series.episodes.where(:name => tvdb_ep.name).first_or_create.tap do |e|
        e.overview = tvdb_ep.overview
        e.thumb = tvdb_ep.thumb
        e.air_date = tvdb_ep.air_date
        e.episode = tvdb_ep.number.to_i
        e.season = tvdb_ep.season_number.to_i
        e.path = video.to_s
        e.save!
      end
      p saved
    end

  end
end  

namespace :terebi do
  desc "update episodes"
  task update: :environment do
    puts "Terebi is updating its database, it should take a minute or so."
    media_path = APP_CONFIG['media_path']
    videos = Dir["#{media_path}/**/*.mkv"].to_a | Dir["#{media_path}/**/*.mp4"].to_a

    videos.each do |episode|
      name = File.basename(episode)
      Episode.add(episode)
    end
    puts "done :)"
  end

  desc "add episode"
  task :add_episode, [:video] => [:environment] do |t, args|
    Episode.add(args[:video])
  end

  desc "settings.yml creation"
  task :install do
    require 'yaml'
    config = {}
    puts "Hi! Welcome to Terebi. I'll walk you through terebi's configuration.\n" +
         "The first thing to setup is the path to your media folder.\n" +
          "Example: C:\\TV Shows\n"
    print "> "
    config["media_path"] = STDIN.gets.chomp.gsub("\\", "/").chomp("/")

    puts "Next up, tell me which language you'd like your subtitles in.\n" +
         "Example: eng"
    print "> "
    config["subs_locale"] = STDIN.gets.chomp

    puts "What about your media player of choice?\n" +
         "Example: C:\\Program Files (x86)\\K-Lite Codec Pack\\Media Player Classic\\mpc-hc.exe"
    print "> "
    config["player"] = STDIN.gets.chomp

    File.open("./config/settings.yml", "w") do |f|
      f.write YAML::dump(config)
    end

    puts "Terebi is now configured, initializing database..."
    Rake::Task["terebi:update"].invoke

  end

end

namespace :terebi do
  desc "update episodes"
  task update_episodes: :environment do
    media_path = Settings.get(:media_path)
    videos = Dir["#{media_path}/**/*.mkv"].to_a | Dir["#{media_path}/**/*.mp4"].to_a

    videos.each do |episode|
      name = File.basename(episode)
      puts "checking #{name}"
      Episode.add(episode)
    end
  end

  desc "add episode"
  task :add_episode, [:video] => [:environment] do |t, args|
    Episode.add(args[:video])
  end

end  

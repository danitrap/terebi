namespace :terebi do
  desc "update episodes"
  task :update_episodes, [:path] => [:environment] do |t, args|
    videos = Dir["#{args[:path]}/**/*.mkv"].to_a | Dir["#{args[:path]}/**/*.mp4"].to_a

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

unless File.basename($0) == "rake" || File.basename($0) == "rspec" || defined?(Rails::Console)
  UpdateEpisodes.schedule_job
  spawn("rake jobs:work")
end
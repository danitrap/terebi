unless File.basename($0) == "rake" || defined?(Rails::Console)
  UpdateEpisodes.schedule_job
  spawn("rake jobs:work")
end
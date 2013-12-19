# preloads calendar data and subtitles availability
unless File.basename($0) == "rake" || defined?(Rails::Console)
  Thread.new {
    Calendar.today
    SubtitlesChecker.check!
    ActiveRecord::Base.connection.close
  }
end
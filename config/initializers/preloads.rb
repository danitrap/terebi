# preloads calendar data and subtitles availability
Thread.new {
  Calendar.today
  SubtitlesChecker.check!
  ActiveRecord::Base.connection.close
}
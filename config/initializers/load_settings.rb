# loads the settings (config/settings.yml)
Settings.load

# preloads calendar data
Thread.new {
  Calendar.today
  ActiveRecord::Base.connection.close
}
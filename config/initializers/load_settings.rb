APP_CONFIG = YAML.load_file("#{Rails.root}/config/settings.yml")

# preloads calendar data
Thread.new {
  Calendar.today
  ActiveRecord::Base.connection.close
}
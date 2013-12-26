if File.exists? "#{Rails.root}/config/settings.yml"
  APP_CONFIG = YAML.load_file("#{Rails.root}/config/settings.yml")
else
  APP_CONFIG = {}
end
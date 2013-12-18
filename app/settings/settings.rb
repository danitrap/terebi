require 'yaml'

module Settings
  extend self

  @_settings = {}
  
  def load
    @_settings = YAML.load_file("#{Rails.root}/config/settings.yml")
  end

  def get(key)
    @_settings[key.to_s]
  end

  def set(key, value)
    @_settings[key.to_s] = value
    write
  end

  def write
    File.open("#{Rails.root}/config/settings.yml", 'w+') do |f|
      f.write(YAML.dump(@_settings))
    end
  end

end

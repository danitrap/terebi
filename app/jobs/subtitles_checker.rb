class SubtitlesChecker
  class << self
    attr_reader :found
    
    def check!
      @found = []
      Episode.where(:seen => false, :subtitles_present => false).each do |episode|
        file = Path.new(episode.path)
        checker = Suby::Downloader::OpenSubtitles.new(file, APP_CONFIG["subs_locale"])
        present = checker.download_url rescue next
        if present.present?
          @found << episode
          episode.update_attribute(:subtitles_present, true)
        end
      end
    end
  end
end
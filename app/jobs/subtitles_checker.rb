class SubtitlesChecker
  class << self
    attr_reader :found
    
    def check!
      @found = []
      Episode.where(:seen => false).each do |episode|
        file = Path.new(episode.path)
        checker = Suby::Downloader::OpenSubtitles.new(file, APP_CONFIG["subs_locale"])
        present = checker.download_url rescue next
        if present.present?
          @found << episode
        end
      end
      @found
    end
  end
end
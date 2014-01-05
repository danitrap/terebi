require 'open-uri'

class Calendar
  FEED = "http://services.tvrage.com/feeds/fullschedule.php?country=US"

  def self.today
    check_cache
  end

  private

  def self.process_feeds
    get_feed
    parse_feed
  end

  def self.get_feed
    @us ||= Nokogiri::XML(open(FEED))
  end

  def self.parse_feed
    date = Time.zone.now.strftime("%Y-%-m-%-d")
    us_schedule = @us.css("schedule DAY[attr=\"#{date}\"] time")

    @today_expires_on = Time.zone.now.midnight + 1.day

    @today = []
    @today << create_shows(us_schedule)
    @today.flatten!.compact!
    @today
  end

  def self.create_shows(schedule)
  schedule.css('show').map do |s|
      Show.new(s.attr('name'), s.css('title').text, s.parent.attr('attr')) if Series.exists?(['name LIKE ?', "%#{s.attr('name')}%"])
    end
  end

  def self.check_cache
    Time.zone = 'Eastern Time (US & Canada)'
    return process_feeds if @today_expires_on.nil?
    
    if Time.zone.now > @today_expires_on
      process_feeds
    else
      @today
    end
  end
end
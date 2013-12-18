require 'open-uri'

class Calendar
  FEED = "http://services.tvrage.com/feeds/fullschedule.php?country=US"
  @@today = []

  def self.today
    @@today.empty? ? process_feeds : @@today
  end

  private

  def self.process_feeds
    get_feed
    parse_feed
  end

  def self.get_feed
    @@today_us ||= Nokogiri::XML(open(FEED))
  end

  def self.parse_feed
    Time.zone = 'Eastern Time (US & Canada)'
    date = Time.zone.now.strftime("%Y-%m-%d")
    us_schedule = @@today_us.css("schedule DAY[attr=\"#{date}\"] time")

    @@today << create_shows(us_schedule)
    @@today.flatten!.compact!
  end

  def self.create_shows(schedule)
    schedule.css('show').map do |s|
      Show.new(s.attr('name'), s.css('title').text, s.parent.attr('attr')) if Series.exists? name: s.attr('name')
    end
  end
end
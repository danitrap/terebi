require 'open-uri'

class Calendar
  FEEDS = {us: "http://services.tvrage.com/feeds/fullschedule.php?country=US", 
           uk: "http://services.tvrage.com/feeds/fullschedule.php?country=UK"}
  @today = []

  def self.today
    @today.empty? ? process_feeds : @today
  end

  private

  def self.process_feeds
    get_feeds
    parse_feeds
  end

  def self.get_feeds
    @today_us ||= Nokogiri::XML(open(FEEDS[:us]))
    @today_uk ||= Nokogiri::XML(open(FEEDS[:uk]))
  end

  def self.parse_feeds
    us_schedule = @today_us.css("schedule DAY[attr=\"#{Date.today.to_s}\"] time")
    uk_schedule = @today_uk.css("schedule DAY[attr=\"#{Date.today.to_s}\"] time")

    @today << create_shows(us_schedule)
    @today << create_shows(uk_schedule)
    @today.flatten!
  end

  def self.create_shows(schedule)
    schedule.css('show').map do |s|
      Show.new(s.attr('name'), s.css('title').text, s.parent.attr('attr')) if Series.exists? name: s.attr('name')
    end
  end
end
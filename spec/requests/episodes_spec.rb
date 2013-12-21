require 'spec_helper'

describe "Episodes" do

  describe "GET /series/1/episodes" do

    before(:each) do
      Episode.add(Rails.root.join('tmp', 'Breaking.Bad.S05E16.720p.HDTV.x264-IMMERSE.mkv').to_s)
      visit series_episodes_url(1)
    end

    it "should have the play button" do
      page.should have_content("Play")
    end

    it "should play the episode" do
      click_link "Play (en)"
      page.should have_content("Downloading")
    end

    it "should mark an episode as watched" do
      click_link "Play (en)"
      page.should have_css("div.seen")
    end

    it "should mark an episode as unwatched" do
      click_link "Play (en)"
      click_link "Mark as unwatched"
      page.should_not have_css("div.seen")
    end

  end
end

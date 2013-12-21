require 'spec_helper'

describe "Series" do

  before(:each) do
      Episode.add(Rails.root.join('tmp', 'Breaking.Bad.S05E16.720p.HDTV.x264-IMMERSE.mkv').to_s)
      visit series_index_url
  end

  describe "GET /series" do

    it "should list breaking bad as a series" do
      page.should have_content("Breaking Bad")
    end

    it "should go to the series episode listing" do
      page.first("div.thumbnail a").click
      current_url.should eq series_episodes_url(1)
    end

  end

end

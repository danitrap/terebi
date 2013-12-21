require 'spec_helper'

describe Episode do
  let(:episode) { Episode.add(Rails.root.join('tmp', 'Breaking.Bad.S05E16.720p.HDTV.x264-IMMERSE.mkv').to_s) }

  it "should add an episode named Felina" do
    episode.name.should eq "Felina"
  end

  it "should have a series name named Breaking Bad" do
    episode.series.name.should eq "Breaking Bad"
  end

  it "should return the metadata" do
    episode.meta.should eq "S05E16"
  end


end

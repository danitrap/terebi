require 'spec_helper'

describe Episode do
  let(:episode) { Episode.add(Rails.root.join('tmp', 'Breaking Bad 5x16 - Felina.mp4').to_s) }

  it "should add an episode named Felina" do
    episode.name.should eq "Felina"
  end

  it "should have a series name named Breaking Bad" do
    episode.series.name.should eq "Breaking Bad"
  end

  it "should return the metadata" do
    episode.meta.should eq "S05E16"
  end

  it "should not add an episode sample" do
    sample = "Series 1x1 - Name.sample.mkv"
    Episode.add(Rails.root.join('tmp', sample).to_s).should be_nil
  end

end

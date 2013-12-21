require 'spec_helper'

describe Series do
  let(:series) { Series.add("Breaking Bad") }

  after { series.banner = nil; series.poster = nil; }
  
  it "should add a series named Breaking Bad" do
    series.name.should eq "Breaking Bad"
  end

  it "should add an unknown series when tvdb fails" do
    Series.add("fake series name").name.should eq "Unknown"
  end

end

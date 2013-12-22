require 'spec_helper'

describe "Home" do

  describe "GET / without any episodes" do
  
    it "should have instructions" do
      visit root_url
      page.should have_content("Welcome to Terebi.")
    end

  end

  describe "normal GET /" do
    before(:each) do
      Episode.add(Rails.root.join('tmp', 'Breaking Bad 5x16 - Felina.mp4').to_s)
      visit root_url
    end
  
    it "should have a new breaking bad episode" do
      page.should have_content("Breaking Bad")
    end

    it "should have a carousel" do
      page.should have_content("Watch")
    end
  end

end

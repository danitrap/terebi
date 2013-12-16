require 'spec_helper'

describe "shows/index" do
  before(:each) do
    assign(:shows, [
      stub_model(Show,
        :name => "Name",
        :poster => "Poster"
      ),
      stub_model(Show,
        :name => "Name",
        :poster => "Poster"
      )
    ])
  end

  it "renders a list of shows" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Poster".to_s, :count => 2
  end
end

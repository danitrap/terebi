require 'spec_helper'

describe "episodes/edit" do
  before(:each) do
    @episode = assign(:episode, stub_model(Episode,
      :name => "MyString",
      :number => 1,
      :path => "MyText",
      :show_id => 1
    ))
  end

  it "renders the edit episode form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", episode_path(@episode), "post" do
      assert_select "input#episode_name[name=?]", "episode[name]"
      assert_select "input#episode_number[name=?]", "episode[number]"
      assert_select "textarea#episode_path[name=?]", "episode[path]"
      assert_select "input#episode_show_id[name=?]", "episode[show_id]"
    end
  end
end

require 'spec_helper'

describe "episodes/new" do
  before(:each) do
    assign(:episode, stub_model(Episode,
      :name => "MyString",
      :number => 1,
      :path => "MyText",
      :show_id => 1
    ).as_new_record)
  end

  it "renders new episode form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", episodes_path, "post" do
      assert_select "input#episode_name[name=?]", "episode[name]"
      assert_select "input#episode_number[name=?]", "episode[number]"
      assert_select "textarea#episode_path[name=?]", "episode[path]"
      assert_select "input#episode_show_id[name=?]", "episode[show_id]"
    end
  end
end

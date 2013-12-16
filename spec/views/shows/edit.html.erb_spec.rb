require 'spec_helper'

describe "shows/edit" do
  before(:each) do
    @show = assign(:show, stub_model(Show,
      :name => "MyString",
      :poster => "MyString"
    ))
  end

  it "renders the edit show form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", show_path(@show), "post" do
      assert_select "input#show_name[name=?]", "show[name]"
      assert_select "input#show_poster[name=?]", "show[poster]"
    end
  end
end

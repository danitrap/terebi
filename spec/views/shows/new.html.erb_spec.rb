require 'spec_helper'

describe "shows/new" do
  before(:each) do
    assign(:show, stub_model(Show,
      :name => "MyString",
      :poster => "MyString"
    ).as_new_record)
  end

  it "renders new show form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", shows_path, "post" do
      assert_select "input#show_name[name=?]", "show[name]"
      assert_select "input#show_poster[name=?]", "show[poster]"
    end
  end
end

require 'spec_helper'

describe "dance_styles/new" do
  before(:each) do
    assign(:dance_style, stub_model(DanceStyle,
      :name => "MyString"
    ).as_new_record)
  end

  it "renders new dance_style form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", dance_styles_path, "post" do
      assert_select "input#dance_style_name[name=?]", "dance_style[name]"
    end
  end
end

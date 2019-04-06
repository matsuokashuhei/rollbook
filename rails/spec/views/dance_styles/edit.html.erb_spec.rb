require 'spec_helper'

describe "dance_styles/edit" do
  before(:each) do
    @dance_style = assign(:dance_style, stub_model(DanceStyle,
      :name => "MyString"
    ))
  end

  it "renders the edit dance_style form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", dance_style_path(@dance_style), "post" do
      assert_select "input#dance_style_name[name=?]", "dance_style[name]"
    end
  end
end

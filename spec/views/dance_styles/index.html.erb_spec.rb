require 'spec_helper'

describe "dance_styles/index" do
  before(:each) do
    assign(:dance_styles, [
      stub_model(DanceStyle,
        :name => "Name"
      ),
      stub_model(DanceStyle,
        :name => "Name"
      )
    ])
  end

  it "renders a list of dance_styles" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
  end
end

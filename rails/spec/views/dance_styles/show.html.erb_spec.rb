require 'spec_helper'

describe "dance_styles/show" do
  before(:each) do
    @dance_style = assign(:dance_style, stub_model(DanceStyle,
      :name => "Name"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
  end
end

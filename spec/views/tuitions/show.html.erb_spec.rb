require 'spec_helper'

describe "tuitions/show" do
  before(:each) do
    @tuition = assign(:tuition, stub_model(Tuition,
      :month => "Month",
      :status => "Status",
      :note => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Month/)
    rendered.should match(/Status/)
    rendered.should match(/MyText/)
  end
end

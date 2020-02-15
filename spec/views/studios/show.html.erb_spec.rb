require 'spec_helper'

describe "studios/show" do
  before(:each) do
    @studio = assign(:studio, stub_model(Studio,
      :name => "Name",
      :note => "Note",
      :school_id => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    rendered.should match(/Note/)
    rendered.should match(/1/)
  end
end

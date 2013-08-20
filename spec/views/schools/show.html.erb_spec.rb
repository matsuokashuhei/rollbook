require 'spec_helper'

describe "schools/show" do
  before(:each) do
    @school = assign(:school, stub_model(School,
      :name => "Name",
      :zip => "Zip",
      :address => "Address",
      :phone => "Phone",
      :note => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    rendered.should match(/Zip/)
    rendered.should match(/Address/)
    rendered.should match(/Phone/)
    rendered.should match(/MyText/)
  end
end

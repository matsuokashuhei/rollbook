require 'spec_helper'

describe "age_groups/show" do
  before(:each) do
    @age_group = assign(:age_group, stub_model(AgeGroup,
      :name => "Name"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
  end
end

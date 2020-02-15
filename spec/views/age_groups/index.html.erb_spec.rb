require 'spec_helper'

describe "age_groups/index" do
  before(:each) do
    assign(:age_groups, [
      stub_model(AgeGroup,
        :name => "Name"
      ),
      stub_model(AgeGroup,
        :name => "Name"
      )
    ])
  end

  it "renders a list of age_groups" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
  end
end

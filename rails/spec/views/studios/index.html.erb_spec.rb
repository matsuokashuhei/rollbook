require 'spec_helper'

describe "studios/index" do
  before(:each) do
    assign(:studios, [
      stub_model(Studio,
        :name => "Name",
        :note => "Note",
        :school_id => 1
      ),
      stub_model(Studio,
        :name => "Name",
        :note => "Note",
        :school_id => 1
      )
    ])
  end

  it "renders a list of studios" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Note".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end

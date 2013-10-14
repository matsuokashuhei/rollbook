require 'spec_helper'

describe "tuitions/index" do
  before(:each) do
    assign(:tuitions, [
      stub_model(Tuition,
        :month => "Month",
        :status => "Status",
        :note => "MyText"
      ),
      stub_model(Tuition,
        :month => "Month",
        :status => "Status",
        :note => "MyText"
      )
    ])
  end

  it "renders a list of tuitions" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Month".to_s, :count => 2
    assert_select "tr>td", :text => "Status".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end

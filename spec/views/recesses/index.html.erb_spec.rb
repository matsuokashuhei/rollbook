require 'spec_helper'

describe "recesses/index" do
  before(:each) do
    assign(:recesses, [
      stub_model(Recess,
        :members_course_id => 1,
        :month => "Month",
        :status => "Status",
        :note => "MyText"
      ),
      stub_model(Recess,
        :members_course_id => 1,
        :month => "Month",
        :status => "Status",
        :note => "MyText"
      )
    ])
  end

  it "renders a list of recesses" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "Month".to_s, :count => 2
    assert_select "tr>td", :text => "Status".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end

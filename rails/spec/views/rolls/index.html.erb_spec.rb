require 'spec_helper'

describe "rolls/index" do
  before(:each) do
    assign(:rolls, [
      stub_model(Roll,
        :lesson_id => 1,
        :member_id => 2,
        :status => "Status",
        :substitute_roll_id => 3
      ),
      stub_model(Roll,
        :lesson_id => 1,
        :member_id => 2,
        :status => "Status",
        :substitute_roll_id => 3
      )
    ])
  end

  it "renders a list of rolls" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "Status".to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
  end
end

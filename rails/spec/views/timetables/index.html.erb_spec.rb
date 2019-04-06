require 'spec_helper'

describe "timetables/index" do
  before(:each) do
    assign(:timetables, [
      stub_model(Timetable,
        :studio_id => 1,
        :cwday => 2,
        :time_slot_id => 3
      ),
      stub_model(Timetable,
        :studio_id => 1,
        :cwday => 2,
        :time_slot_id => 3
      )
    ])
  end

  it "renders a list of timetables" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
  end
end

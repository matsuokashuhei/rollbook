require 'spec_helper'

describe "time_slots/index" do
  before(:each) do
    assign(:time_slots, [
      stub_model(TimeSlot),
      stub_model(TimeSlot)
    ])
  end

  it "renders a list of time_slots" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end

require 'spec_helper'

describe "timetables/show" do
  before(:each) do
    @timetable = assign(:timetable, stub_model(Timetable,
      :studio_id => 1,
      :cwday => 2,
      :time_slot_id => 3
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/2/)
    rendered.should match(/3/)
  end
end

require 'spec_helper'

describe "timetables/edit" do
  before(:each) do
    @timetable = assign(:timetable, stub_model(Timetable,
      :studio_id => 1,
      :cwday => 1,
      :time_slot_id => 1
    ))
  end

  it "renders the edit timetable form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", timetable_path(@timetable), "post" do
      assert_select "input#timetable_studio_id[name=?]", "timetable[studio_id]"
      assert_select "input#timetable_cwday[name=?]", "timetable[cwday]"
      assert_select "input#timetable_time_slot_id[name=?]", "timetable[time_slot_id]"
    end
  end
end

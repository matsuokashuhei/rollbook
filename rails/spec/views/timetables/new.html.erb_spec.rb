require 'spec_helper'

describe "timetables/new" do
  before(:each) do
    assign(:timetable, stub_model(Timetable,
      :studio_id => 1,
      :cwday => 1,
      :time_slot_id => 1
    ).as_new_record)
  end

  it "renders new timetable form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", timetables_path, "post" do
      assert_select "input#timetable_studio_id[name=?]", "timetable[studio_id]"
      assert_select "input#timetable_cwday[name=?]", "timetable[cwday]"
      assert_select "input#timetable_time_slot_id[name=?]", "timetable[time_slot_id]"
    end
  end
end

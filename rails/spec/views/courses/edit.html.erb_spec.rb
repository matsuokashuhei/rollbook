require 'spec_helper'

describe "courses/edit" do
  before(:each) do
    @course = assign(:course, stub_model(Course,
      :timetable_id => 1,
      :instructor_id => 1,
      :dance_style_id => 1,
      :level_id => 1,
      :age_group_id => 1,
      :note => "MyText",
      :monthly_fee => 1
    ))
  end

  it "renders the edit course form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", course_path(@course), "post" do
      assert_select "input#course_timetable_id[name=?]", "course[timetable_id]"
      assert_select "input#course_instructor_id[name=?]", "course[instructor_id]"
      assert_select "input#course_dance_style_id[name=?]", "course[dance_style_id]"
      assert_select "input#course_level_id[name=?]", "course[level_id]"
      assert_select "input#course_age_group_id[name=?]", "course[age_group_id]"
      assert_select "textarea#course_note[name=?]", "course[note]"
      assert_select "input#course_monthly_fee[name=?]", "course[monthly_fee]"
    end
  end
end

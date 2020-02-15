require 'spec_helper'

describe "courses/show" do
  before(:each) do
    @course = assign(:course, stub_model(Course,
      :timetable_id => 1,
      :instructor_id => 2,
      :dance_style_id => 3,
      :level_id => 4,
      :age_group_id => 5,
      :note => "MyText",
      :monthly_fee => 6
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/2/)
    rendered.should match(/3/)
    rendered.should match(/4/)
    rendered.should match(/5/)
    rendered.should match(/MyText/)
    rendered.should match(/6/)
  end
end

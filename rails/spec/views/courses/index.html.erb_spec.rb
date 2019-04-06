require 'spec_helper'

describe "courses/index" do
  before(:each) do
    assign(:courses, [
      stub_model(Course,
        :timetable_id => 1,
        :instructor_id => 2,
        :dance_style_id => 3,
        :level_id => 4,
        :age_group_id => 5,
        :note => "MyText",
        :monthly_fee => 6
      ),
      stub_model(Course,
        :timetable_id => 1,
        :instructor_id => 2,
        :dance_style_id => 3,
        :level_id => 4,
        :age_group_id => 5,
        :note => "MyText",
        :monthly_fee => 6
      )
    ])
  end

  it "renders a list of courses" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => 4.to_s, :count => 2
    assert_select "tr>td", :text => 5.to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => 6.to_s, :count => 2
  end
end

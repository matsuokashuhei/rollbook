require 'spec_helper'

describe "members_courses/index" do
  before(:each) do
    assign(:members_courses, [
      stub_model(MembersCourse,
        :member_id => 1,
        :course_id => 2,
        :note => "MyText",
        :introduction => false
      ),
      stub_model(MembersCourse,
        :member_id => 1,
        :course_id => 2,
        :note => "MyText",
        :introduction => false
      )
    ])
  end

  it "renders a list of members_courses" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
  end
end

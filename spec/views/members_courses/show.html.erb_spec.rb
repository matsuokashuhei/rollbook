require 'spec_helper'

describe "members_courses/show" do
  before(:each) do
    @members_course = assign(:members_course, stub_model(MembersCourse,
      :member_id => 1,
      :course_id => 2,
      :note => "MyText",
      :introduction => false
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/2/)
    rendered.should match(/MyText/)
    rendered.should match(/false/)
  end
end

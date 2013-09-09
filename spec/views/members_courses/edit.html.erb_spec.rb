require 'spec_helper'

describe "members_courses/edit" do
  before(:each) do
    @members_course = assign(:members_course, stub_model(MembersCourse,
      :member_id => 1,
      :course_id => 1,
      :note => "MyText",
      :introduction => false
    ))
  end

  it "renders the edit members_course form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", members_course_path(@members_course), "post" do
      assert_select "input#members_course_member_id[name=?]", "members_course[member_id]"
      assert_select "input#members_course_course_id[name=?]", "members_course[course_id]"
      assert_select "textarea#members_course_note[name=?]", "members_course[note]"
      assert_select "input#members_course_introduction[name=?]", "members_course[introduction]"
    end
  end
end

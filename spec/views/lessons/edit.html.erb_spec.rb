require 'spec_helper'

describe "lessons/edit" do
  before(:each) do
    @lesson = assign(:lesson, stub_model(Lesson,
      :course_id => 1,
      :status => "MyString",
      :note => "MyText"
    ))
  end

  it "renders the edit lesson form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", lesson_path(@lesson), "post" do
      assert_select "input#lesson_course_id[name=?]", "lesson[course_id]"
      assert_select "input#lesson_status[name=?]", "lesson[status]"
      assert_select "textarea#lesson_note[name=?]", "lesson[note]"
    end
  end
end

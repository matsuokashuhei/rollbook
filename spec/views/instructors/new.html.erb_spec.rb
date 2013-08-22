require 'spec_helper'

describe "instructors/new" do
  before(:each) do
    assign(:instructor, stub_model(Instructor,
      :name => "MyString",
      :kana => "MyString",
      :team => "MyString",
      :phone => "MyString",
      :email_pc => "MyString",
      :email_mobile => "MyString",
      :note => "MyText"
    ).as_new_record)
  end

  it "renders new instructor form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", instructors_path, "post" do
      assert_select "input#instructor_name[name=?]", "instructor[name]"
      assert_select "input#instructor_kana[name=?]", "instructor[kana]"
      assert_select "input#instructor_team[name=?]", "instructor[team]"
      assert_select "input#instructor_phone[name=?]", "instructor[phone]"
      assert_select "input#instructor_email_pc[name=?]", "instructor[email_pc]"
      assert_select "input#instructor_email_mobile[name=?]", "instructor[email_mobile]"
      assert_select "textarea#instructor_note[name=?]", "instructor[note]"
    end
  end
end

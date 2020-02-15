require 'spec_helper'

describe "instructors/edit" do
  before(:each) do
    @instructor = assign(:instructor, stub_model(Instructor,
      :name => "MyString",
      :kana => "MyString",
      :team => "MyString",
      :phone => "MyString",
      :email_pc => "MyString",
      :email_mobile => "MyString",
      :note => "MyText"
    ))
  end

  it "renders the edit instructor form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", instructor_path(@instructor), "post" do
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

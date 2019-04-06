require 'spec_helper'

describe "recesses/new" do
  before(:each) do
    assign(:recess, stub_model(Recess,
      :members_course_id => 1,
      :month => "MyString",
      :status => "MyString",
      :note => "MyText"
    ).as_new_record)
  end

  it "renders new recess form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", recesses_path, "post" do
      assert_select "input#recess_members_course_id[name=?]", "recess[members_course_id]"
      assert_select "input#recess_month[name=?]", "recess[month]"
      assert_select "input#recess_status[name=?]", "recess[status]"
      assert_select "textarea#recess_note[name=?]", "recess[note]"
    end
  end
end

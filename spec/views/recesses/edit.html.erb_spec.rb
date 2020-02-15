require 'spec_helper'

describe "recesses/edit" do
  before(:each) do
    @recess = assign(:recess, stub_model(Recess,
      :members_course_id => 1,
      :month => "MyString",
      :status => "MyString",
      :note => "MyText"
    ))
  end

  it "renders the edit recess form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", recess_path(@recess), "post" do
      assert_select "input#recess_members_course_id[name=?]", "recess[members_course_id]"
      assert_select "input#recess_month[name=?]", "recess[month]"
      assert_select "input#recess_status[name=?]", "recess[status]"
      assert_select "textarea#recess_note[name=?]", "recess[note]"
    end
  end
end

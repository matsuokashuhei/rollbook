require 'spec_helper'

describe "schools/edit" do
  before(:each) do
    @school = assign(:school, stub_model(School,
      :name => "MyString",
      :zip => "MyString",
      :address => "MyString",
      :phone => "MyString",
      :note => "MyText"
    ))
  end

  it "renders the edit school form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", school_path(@school), "post" do
      assert_select "input#school_name[name=?]", "school[name]"
      assert_select "input#school_zip[name=?]", "school[zip]"
      assert_select "input#school_address[name=?]", "school[address]"
      assert_select "input#school_phone[name=?]", "school[phone]"
      assert_select "textarea#school_note[name=?]", "school[note]"
    end
  end
end

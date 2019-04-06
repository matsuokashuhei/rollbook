require 'spec_helper'

describe "schools/new" do
  before(:each) do
    assign(:school, stub_model(School,
      :name => "MyString",
      :zip => "MyString",
      :address => "MyString",
      :phone => "MyString",
      :note => "MyText"
    ).as_new_record)
  end

  it "renders new school form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", schools_path, "post" do
      assert_select "input#school_name[name=?]", "school[name]"
      assert_select "input#school_zip[name=?]", "school[zip]"
      assert_select "input#school_address[name=?]", "school[address]"
      assert_select "input#school_phone[name=?]", "school[phone]"
      assert_select "textarea#school_note[name=?]", "school[note]"
    end
  end
end

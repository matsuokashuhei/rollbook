require 'spec_helper'

describe "tuitions/new" do
  before(:each) do
    assign(:tuition, stub_model(Tuition,
      :month => "MyString",
      :status => "MyString",
      :note => "MyText"
    ).as_new_record)
  end

  it "renders new tuition form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", tuitions_path, "post" do
      assert_select "input#tuition_month[name=?]", "tuition[month]"
      assert_select "input#tuition_status[name=?]", "tuition[status]"
      assert_select "textarea#tuition_note[name=?]", "tuition[note]"
    end
  end
end

require 'spec_helper'

describe "tuitions/edit" do
  before(:each) do
    @tuition = assign(:tuition, stub_model(Tuition,
      :month => "MyString",
      :status => "MyString",
      :note => "MyText"
    ))
  end

  it "renders the edit tuition form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", tuition_path(@tuition), "post" do
      assert_select "input#tuition_month[name=?]", "tuition[month]"
      assert_select "input#tuition_status[name=?]", "tuition[status]"
      assert_select "textarea#tuition_note[name=?]", "tuition[note]"
    end
  end
end

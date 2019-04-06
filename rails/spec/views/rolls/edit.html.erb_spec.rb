require 'spec_helper'

describe "rolls/edit" do
  before(:each) do
    @roll = assign(:roll, stub_model(Roll,
      :lesson_id => 1,
      :member_id => 1,
      :status => "MyString",
      :substitute_roll_id => 1
    ))
  end

  it "renders the edit roll form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", roll_path(@roll), "post" do
      assert_select "input#roll_lesson_id[name=?]", "roll[lesson_id]"
      assert_select "input#roll_member_id[name=?]", "roll[member_id]"
      assert_select "input#roll_status[name=?]", "roll[status]"
      assert_select "input#roll_substitute_roll_id[name=?]", "roll[substitute_roll_id]"
    end
  end
end

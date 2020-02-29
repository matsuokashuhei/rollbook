require 'spec_helper'

describe "rolls/show" do
  before(:each) do
    @roll = assign(:roll, stub_model(Roll,
      :lesson_id => 1,
      :member_id => 2,
      :status => "Status",
      :substitute_roll_id => 3
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/2/)
    rendered.should match(/Status/)
    rendered.should match(/3/)
  end
end

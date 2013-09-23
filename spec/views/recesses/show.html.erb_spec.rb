require 'spec_helper'

describe "recesses/show" do
  before(:each) do
    @recess = assign(:recess, stub_model(Recess,
      :members_course_id => 1,
      :month => "Month",
      :status => "Status",
      :note => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/Month/)
    rendered.should match(/Status/)
    rendered.should match(/MyText/)
  end
end

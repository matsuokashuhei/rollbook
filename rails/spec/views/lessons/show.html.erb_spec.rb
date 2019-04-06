require 'spec_helper'

describe "lessons/show" do
  before(:each) do
    @lesson = assign(:lesson, stub_model(Lesson,
      :course_id => 1,
      :status => "Status",
      :note => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/Status/)
    rendered.should match(/MyText/)
  end
end

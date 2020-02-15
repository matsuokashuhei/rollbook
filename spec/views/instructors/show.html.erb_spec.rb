require 'spec_helper'

describe "instructors/show" do
  before(:each) do
    @instructor = assign(:instructor, stub_model(Instructor,
      :name => "Name",
      :kana => "Kana",
      :team => "Team",
      :phone => "Phone",
      :email_pc => "Email Pc",
      :email_mobile => "Email Mobile",
      :note => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    rendered.should match(/Kana/)
    rendered.should match(/Team/)
    rendered.should match(/Phone/)
    rendered.should match(/Email Pc/)
    rendered.should match(/Email Mobile/)
    rendered.should match(/MyText/)
  end
end

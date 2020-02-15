require 'spec_helper'

describe "instructors/index" do
  before(:each) do
    assign(:instructors, [
      stub_model(Instructor,
        :name => "Name",
        :kana => "Kana",
        :team => "Team",
        :phone => "Phone",
        :email_pc => "Email Pc",
        :email_mobile => "Email Mobile",
        :note => "MyText"
      ),
      stub_model(Instructor,
        :name => "Name",
        :kana => "Kana",
        :team => "Team",
        :phone => "Phone",
        :email_pc => "Email Pc",
        :email_mobile => "Email Mobile",
        :note => "MyText"
      )
    ])
  end

  it "renders a list of instructors" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Kana".to_s, :count => 2
    assert_select "tr>td", :text => "Team".to_s, :count => 2
    assert_select "tr>td", :text => "Phone".to_s, :count => 2
    assert_select "tr>td", :text => "Email Pc".to_s, :count => 2
    assert_select "tr>td", :text => "Email Mobile".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end

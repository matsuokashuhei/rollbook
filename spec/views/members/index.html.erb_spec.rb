require 'spec_helper'

describe "members/index" do
  before(:each) do
    assign(:members, [
      stub_model(Member,
        :first_name => "First Name",
        :last_name => "Last Name",
        :first_name_kana => "First Name Kana",
        :last_name_kana => "Last Name Kana",
        :gender => "Gender",
        :zip => "Zip",
        :address => "Address",
        :phone => "Phone",
        :email_pc => "Email Pc",
        :email_mobile => "Email Mobile",
        :note => "MyText",
        :bank_account_id => 1,
        :status => 2,
        :nearby_station => "Nearby Station"
      ),
      stub_model(Member,
        :first_name => "First Name",
        :last_name => "Last Name",
        :first_name_kana => "First Name Kana",
        :last_name_kana => "Last Name Kana",
        :gender => "Gender",
        :zip => "Zip",
        :address => "Address",
        :phone => "Phone",
        :email_pc => "Email Pc",
        :email_mobile => "Email Mobile",
        :note => "MyText",
        :bank_account_id => 1,
        :status => 2,
        :nearby_station => "Nearby Station"
      )
    ])
  end

  it "renders a list of members" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "First Name".to_s, :count => 2
    assert_select "tr>td", :text => "Last Name".to_s, :count => 2
    assert_select "tr>td", :text => "First Name Kana".to_s, :count => 2
    assert_select "tr>td", :text => "Last Name Kana".to_s, :count => 2
    assert_select "tr>td", :text => "Gender".to_s, :count => 2
    assert_select "tr>td", :text => "Zip".to_s, :count => 2
    assert_select "tr>td", :text => "Address".to_s, :count => 2
    assert_select "tr>td", :text => "Phone".to_s, :count => 2
    assert_select "tr>td", :text => "Email Pc".to_s, :count => 2
    assert_select "tr>td", :text => "Email Mobile".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "Nearby Station".to_s, :count => 2
  end
end

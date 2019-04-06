require 'spec_helper'

describe "members/show" do
  before(:each) do
    @member = assign(:member, stub_model(Member,
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
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/First Name/)
    rendered.should match(/Last Name/)
    rendered.should match(/First Name Kana/)
    rendered.should match(/Last Name Kana/)
    rendered.should match(/Gender/)
    rendered.should match(/Zip/)
    rendered.should match(/Address/)
    rendered.should match(/Phone/)
    rendered.should match(/Email Pc/)
    rendered.should match(/Email Mobile/)
    rendered.should match(/MyText/)
    rendered.should match(/1/)
    rendered.should match(/2/)
    rendered.should match(/Nearby Station/)
  end
end

require 'spec_helper'

describe "bank_accounts/index" do
  before(:each) do
    assign(:bank_accounts, [
      stub_model(BankAccount,
        :holder_name => "Holder Name",
        :holder_name_kana => "Holder Name Kana",
        :bank_id => "Bank",
        :bank_name => "Bank Name",
        :branch_id => "Branch",
        :branch_name => "Branch Name",
        :account_number => "Account Number",
        :status => "Status",
        :note => "MyText"
      ),
      stub_model(BankAccount,
        :holder_name => "Holder Name",
        :holder_name_kana => "Holder Name Kana",
        :bank_id => "Bank",
        :bank_name => "Bank Name",
        :branch_id => "Branch",
        :branch_name => "Branch Name",
        :account_number => "Account Number",
        :status => "Status",
        :note => "MyText"
      )
    ])
  end

  it "renders a list of bank_accounts" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Holder Name".to_s, :count => 2
    assert_select "tr>td", :text => "Holder Name Kana".to_s, :count => 2
    assert_select "tr>td", :text => "Bank".to_s, :count => 2
    assert_select "tr>td", :text => "Bank Name".to_s, :count => 2
    assert_select "tr>td", :text => "Branch".to_s, :count => 2
    assert_select "tr>td", :text => "Branch Name".to_s, :count => 2
    assert_select "tr>td", :text => "Account Number".to_s, :count => 2
    assert_select "tr>td", :text => "Status".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end

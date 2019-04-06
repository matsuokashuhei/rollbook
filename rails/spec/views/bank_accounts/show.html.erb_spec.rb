require 'spec_helper'

describe "bank_accounts/show" do
  before(:each) do
    @bank_account = assign(:bank_account, stub_model(BankAccount,
      :holder_name => "Holder Name",
      :holder_name_kana => "Holder Name Kana",
      :bank_id => "Bank",
      :bank_name => "Bank Name",
      :branch_id => "Branch",
      :branch_name => "Branch Name",
      :account_number => "Account Number",
      :status => "Status",
      :note => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Holder Name/)
    rendered.should match(/Holder Name Kana/)
    rendered.should match(/Bank/)
    rendered.should match(/Bank Name/)
    rendered.should match(/Branch/)
    rendered.should match(/Branch Name/)
    rendered.should match(/Account Number/)
    rendered.should match(/Status/)
    rendered.should match(/MyText/)
  end
end

require 'spec_helper'

describe "bank_accounts/new" do
  before(:each) do
    assign(:bank_account, stub_model(BankAccount,
      :holder_name => "MyString",
      :holder_name_kana => "MyString",
      :bank_id => "MyString",
      :bank_name => "MyString",
      :branch_id => "MyString",
      :branch_name => "MyString",
      :account_number => "MyString",
      :status => "MyString",
      :note => "MyText"
    ).as_new_record)
  end

  it "renders new bank_account form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", bank_accounts_path, "post" do
      assert_select "input#bank_account_holder_name[name=?]", "bank_account[holder_name]"
      assert_select "input#bank_account_holder_name_kana[name=?]", "bank_account[holder_name_kana]"
      assert_select "input#bank_account_bank_id[name=?]", "bank_account[bank_id]"
      assert_select "input#bank_account_bank_name[name=?]", "bank_account[bank_name]"
      assert_select "input#bank_account_branch_id[name=?]", "bank_account[branch_id]"
      assert_select "input#bank_account_branch_name[name=?]", "bank_account[branch_name]"
      assert_select "input#bank_account_account_number[name=?]", "bank_account[account_number]"
      assert_select "input#bank_account_status[name=?]", "bank_account[status]"
      assert_select "textarea#bank_account_note[name=?]", "bank_account[note]"
    end
  end
end

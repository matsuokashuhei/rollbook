require 'spec_helper'

describe "debits/edit" do
  before(:each) do
    @debit = assign(:debit, stub_model(Debit,
      :bank_account_id => 1,
      :month => "MyString",
      : => "",
      :status => "MyString",
      :note => "MyText"
    ))
  end

  it "renders the edit debit form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", debit_path(@debit), "post" do
      assert_select "input#debit_bank_account_id[name=?]", "debit[bank_account_id]"
      assert_select "input#debit_month[name=?]", "debit[month]"
      assert_select "input#debit_[name=?]", "debit[]"
      assert_select "input#debit_status[name=?]", "debit[status]"
      assert_select "textarea#debit_note[name=?]", "debit[note]"
    end
  end
end

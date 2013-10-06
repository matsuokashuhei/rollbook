require 'spec_helper'

describe "debits/new" do
  before(:each) do
    assign(:debit, stub_model(Debit,
      :bank_account_id => 1,
      :month => "MyString",
      : => "",
      :status => "MyString",
      :note => "MyText"
    ).as_new_record)
  end

  it "renders new debit form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", debits_path, "post" do
      assert_select "input#debit_bank_account_id[name=?]", "debit[bank_account_id]"
      assert_select "input#debit_month[name=?]", "debit[month]"
      assert_select "input#debit_[name=?]", "debit[]"
      assert_select "input#debit_status[name=?]", "debit[status]"
      assert_select "textarea#debit_note[name=?]", "debit[note]"
    end
  end
end

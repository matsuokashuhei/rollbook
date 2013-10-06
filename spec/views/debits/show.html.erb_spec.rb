require 'spec_helper'

describe "debits/show" do
  before(:each) do
    @debit = assign(:debit, stub_model(Debit,
      :bank_account_id => 1,
      :month => "Month",
      : => "",
      :status => "Status",
      :note => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/Month/)
    rendered.should match(//)
    rendered.should match(/Status/)
    rendered.should match(/MyText/)
  end
end

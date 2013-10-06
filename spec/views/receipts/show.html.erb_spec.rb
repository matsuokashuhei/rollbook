require 'spec_helper'

describe "receipts/show" do
  before(:each) do
    @receipt = assign(:receipt, stub_model(Receipt,
      :member_id => 1,
      :month => "Month",
      :amount => 2,
      :method => "Method",
      :status => "Status",
      :debit_id => 3,
      :note => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/Month/)
    rendered.should match(/2/)
    rendered.should match(/Method/)
    rendered.should match(/Status/)
    rendered.should match(/3/)
    rendered.should match(/MyText/)
  end
end

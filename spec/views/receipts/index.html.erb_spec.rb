require 'spec_helper'

describe "receipts/index" do
  before(:each) do
    assign(:receipts, [
      stub_model(Receipt,
        :member_id => 1,
        :month => "Month",
        :amount => 2,
        :method => "Method",
        :status => "Status",
        :debit_id => 3,
        :note => "MyText"
      ),
      stub_model(Receipt,
        :member_id => 1,
        :month => "Month",
        :amount => 2,
        :method => "Method",
        :status => "Status",
        :debit_id => 3,
        :note => "MyText"
      )
    ])
  end

  it "renders a list of receipts" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "Month".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "Method".to_s, :count => 2
    assert_select "tr>td", :text => "Status".to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end

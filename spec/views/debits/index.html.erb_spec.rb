require 'spec_helper'

describe "debits/index" do
  before(:each) do
    assign(:debits, [
      stub_model(Debit,
        :bank_account_id => 1,
        :month => "Month",
        : => "",
        :status => "Status",
        :note => "MyText"
      ),
      stub_model(Debit,
        :bank_account_id => 1,
        :month => "Month",
        : => "",
        :status => "Status",
        :note => "MyText"
      )
    ])
  end

  it "renders a list of debits" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "Month".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "Status".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end

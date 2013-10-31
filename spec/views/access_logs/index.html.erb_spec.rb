require 'spec_helper'

describe "access_logs/index" do
  before(:each) do
    assign(:access_logs, [
      stub_model(AccessLog,
        :user_id => 1,
        :ip => "Ip",
        :remote_ip => "Remote Ip",
        :request_method => "Request Method",
        :fullpath => "Fullpath"
      ),
      stub_model(AccessLog,
        :user_id => 1,
        :ip => "Ip",
        :remote_ip => "Remote Ip",
        :request_method => "Request Method",
        :fullpath => "Fullpath"
      )
    ])
  end

  it "renders a list of access_logs" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "Ip".to_s, :count => 2
    assert_select "tr>td", :text => "Remote Ip".to_s, :count => 2
    assert_select "tr>td", :text => "Request Method".to_s, :count => 2
    assert_select "tr>td", :text => "Fullpath".to_s, :count => 2
  end
end

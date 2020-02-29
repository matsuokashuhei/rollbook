require 'spec_helper'

describe "access_logs/show" do
  before(:each) do
    @access_log = assign(:access_log, stub_model(AccessLog,
      :user_id => 1,
      :ip => "Ip",
      :remote_ip => "Remote Ip",
      :request_method => "Request Method",
      :fullpath => "Fullpath"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/Ip/)
    rendered.should match(/Remote Ip/)
    rendered.should match(/Request Method/)
    rendered.should match(/Fullpath/)
  end
end

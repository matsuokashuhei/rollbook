require 'spec_helper'

describe "access_logs/new" do
  before(:each) do
    assign(:access_log, stub_model(AccessLog,
      :user_id => 1,
      :ip => "MyString",
      :remote_ip => "MyString",
      :request_method => "MyString",
      :fullpath => "MyString"
    ).as_new_record)
  end

  it "renders new access_log form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", access_logs_path, "post" do
      assert_select "input#access_log_user_id[name=?]", "access_log[user_id]"
      assert_select "input#access_log_ip[name=?]", "access_log[ip]"
      assert_select "input#access_log_remote_ip[name=?]", "access_log[remote_ip]"
      assert_select "input#access_log_request_method[name=?]", "access_log[request_method]"
      assert_select "input#access_log_fullpath[name=?]", "access_log[fullpath]"
    end
  end
end

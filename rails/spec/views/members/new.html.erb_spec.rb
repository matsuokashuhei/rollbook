require 'spec_helper'

describe "members/new" do
  before(:each) do
    assign(:member, stub_model(Member,
      :first_name => "MyString",
      :last_name => "MyString",
      :first_name_kana => "MyString",
      :last_name_kana => "MyString",
      :gender => "MyString",
      :zip => "MyString",
      :address => "MyString",
      :phone => "MyString",
      :email_pc => "MyString",
      :email_mobile => "MyString",
      :note => "MyText",
      :bank_account_id => 1,
      :status => 1,
      :nearby_station => "MyString"
    ).as_new_record)
  end

  it "renders new member form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", members_path, "post" do
      assert_select "input#member_first_name[name=?]", "member[first_name]"
      assert_select "input#member_last_name[name=?]", "member[last_name]"
      assert_select "input#member_first_name_kana[name=?]", "member[first_name_kana]"
      assert_select "input#member_last_name_kana[name=?]", "member[last_name_kana]"
      assert_select "input#member_gender[name=?]", "member[gender]"
      assert_select "input#member_zip[name=?]", "member[zip]"
      assert_select "input#member_address[name=?]", "member[address]"
      assert_select "input#member_phone[name=?]", "member[phone]"
      assert_select "input#member_email_pc[name=?]", "member[email_pc]"
      assert_select "input#member_email_mobile[name=?]", "member[email_mobile]"
      assert_select "textarea#member_note[name=?]", "member[note]"
      assert_select "input#member_bank_account_id[name=?]", "member[bank_account_id]"
      assert_select "input#member_status[name=?]", "member[status]"
      assert_select "input#member_nearby_station[name=?]", "member[nearby_station]"
    end
  end
end

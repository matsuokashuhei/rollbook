require 'spec_helper'

describe "age_groups/new" do
  before(:each) do
    assign(:age_group, stub_model(AgeGroup,
      :name => "MyString"
    ).as_new_record)
  end

  it "renders new age_group form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", age_groups_path, "post" do
      assert_select "input#age_group_name[name=?]", "age_group[name]"
    end
  end
end

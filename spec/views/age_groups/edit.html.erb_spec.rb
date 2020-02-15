require 'spec_helper'

describe "age_groups/edit" do
  before(:each) do
    @age_group = assign(:age_group, stub_model(AgeGroup,
      :name => "MyString"
    ))
  end

  it "renders the edit age_group form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", age_group_path(@age_group), "post" do
      assert_select "input#age_group_name[name=?]", "age_group[name]"
    end
  end
end

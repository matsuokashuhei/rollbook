require 'spec_helper'

describe "studios/edit" do
  before(:each) do
    @studio = assign(:studio, stub_model(Studio,
      :name => "MyString",
      :note => "MyString",
      :school_id => 1
    ))
  end

  it "renders the edit studio form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", studio_path(@studio), "post" do
      assert_select "input#studio_name[name=?]", "studio[name]"
      assert_select "input#studio_note[name=?]", "studio[note]"
      assert_select "input#studio_school_id[name=?]", "studio[school_id]"
    end
  end
end

require 'spec_helper'

describe "tasks/edit" do
  before(:each) do
    @task = assign(:task, stub_model(Task,
      :name => "MyString",
      :frequency => "MyString",
      :status => "MyString",
      :note => "MyText"
    ))
  end

  it "renders the edit task form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", task_path(@task), "post" do
      assert_select "input#task_name[name=?]", "task[name]"
      assert_select "input#task_frequency[name=?]", "task[frequency]"
      assert_select "input#task_status[name=?]", "task[status]"
      assert_select "textarea#task_note[name=?]", "task[note]"
    end
  end
end

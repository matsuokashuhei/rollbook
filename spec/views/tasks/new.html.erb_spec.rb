require 'spec_helper'

describe "tasks/new" do
  before(:each) do
    assign(:task, stub_model(Task,
      :name => "MyString",
      :frequency => "MyString",
      :status => "MyString",
      :note => "MyText"
    ).as_new_record)
  end

  it "renders new task form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", tasks_path, "post" do
      assert_select "input#task_name[name=?]", "task[name]"
      assert_select "input#task_frequency[name=?]", "task[frequency]"
      assert_select "input#task_status[name=?]", "task[status]"
      assert_select "textarea#task_note[name=?]", "task[note]"
    end
  end
end

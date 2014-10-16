class AddGuaranteedMinimumToInstructors < ActiveRecord::Migration
  def change
    add_column :instructors, :guaranteed_min, :integer
  end
end

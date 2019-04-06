class AddGuaranteedMinimumToInstructors < ActiveRecord::Migration[4.2]
  def change
    add_column :instructors, :guaranteed_min, :integer
  end
end

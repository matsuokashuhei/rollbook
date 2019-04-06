class AddTransportationToInstructors < ActiveRecord::Migration[4.2]
  def change
    add_column :instructors, :transportation, :integer
  end
end

class AddTransportationToInstructors < ActiveRecord::Migration
  def change
    add_column :instructors, :transportation, :integer
  end
end

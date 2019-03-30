class AddTaxableToInstructor < ActiveRecord::Migration
  def change
    add_column :instructors, :taxable, :boolean
  end
end

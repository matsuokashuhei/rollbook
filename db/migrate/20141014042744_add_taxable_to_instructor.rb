class AddTaxableToInstructor < ActiveRecord::Migration[4.2]
  def change
    add_column :instructors, :taxable, :boolean
  end
end

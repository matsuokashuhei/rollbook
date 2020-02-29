class AddFkToSchoolIdOnStudios < ActiveRecord::Migration[5.1]
  def change
    add_foreign_key :studios, :schools, column: :school_id
  end
end

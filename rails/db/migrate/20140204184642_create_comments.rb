class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :post_id
      t.text :content
      t.integer :user_id

      t.timestamps
    end
  end
end

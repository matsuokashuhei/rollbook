class AddFkToPostIdOnComments < ActiveRecord::Migration[5.1]
  def change
    add_foreign_key :comments, :posts, column: :post_id
  end
end

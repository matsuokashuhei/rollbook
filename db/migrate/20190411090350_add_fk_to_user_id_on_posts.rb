class AddFkToUserIdOnPosts < ActiveRecord::Migration[5.1]
  def change
    add_foreign_key :posts, :users, column: :user_id
  end
end

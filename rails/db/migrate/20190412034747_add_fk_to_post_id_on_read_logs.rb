class AddFkToPostIdOnReadLogs < ActiveRecord::Migration[5.1]
  def change
    add_foreign_key :read_logs, :posts, column: :post_id
  end
end

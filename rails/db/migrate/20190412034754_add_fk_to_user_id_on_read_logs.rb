class AddFkToUserIdOnReadLogs < ActiveRecord::Migration[5.1]
  def change
    add_foreign_key :read_logs, :users, column: :user_id
  end
end

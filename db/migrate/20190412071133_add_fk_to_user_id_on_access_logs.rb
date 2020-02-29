class AddFkToUserIdOnAccessLogs < ActiveRecord::Migration[5.1]
  def change
    add_foreign_key :access_logs, :users, column: :user_id
  end
end

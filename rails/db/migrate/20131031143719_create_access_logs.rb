class CreateAccessLogs < ActiveRecord::Migration
  def change
    create_table :access_logs do |t|
      t.integer :user_id
      t.string :ip
      t.string :remote_ip
      t.string :request_method
      t.string :fullpath

      t.timestamps
    end
  end
end

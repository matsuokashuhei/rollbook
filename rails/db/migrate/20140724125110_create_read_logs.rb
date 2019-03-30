class CreateReadLogs < ActiveRecord::Migration
  def change
    create_table :read_logs do |t|
      t.integer :post_id
      t.integer :user_id
      t.integer :read_comments_count

      t.timestamps
    end
  end
end

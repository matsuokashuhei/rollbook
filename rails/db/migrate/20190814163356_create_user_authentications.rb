# frozen_string_literal: true

class CreateUserAuthentications < ActiveRecord::Migration[5.1]
  def change
    create_table :user_authentications do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :provider
      t.string :sub

      t.timestamps

      t.index %i[provider sub], unique: true
    end
  end
end

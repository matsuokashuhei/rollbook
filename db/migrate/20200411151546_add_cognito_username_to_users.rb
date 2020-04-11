class AddCognitoUsernameToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :cognito_username, :string
  end
end

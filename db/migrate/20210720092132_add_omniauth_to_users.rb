class AddOmniauthToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :provider, :string
    add_column :users, :spotify_id, :string
    add_column :users, :avatar_url, :string
    add_column :users, :token, :string
    add_column :users, :token_expiry, :datetime
  end
end

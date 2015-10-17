class AddTwitterToUser < ActiveRecord::Migration
  def change
    add_column :users, :provider, :string
    add_column :users, :uid, :string
    add_column :users, :twitter_token, :string
    add_column :users, :twitter_secret, :string
  end
end

class AddWordpressOauth2FieldsToUser < ActiveRecord::Migration
  def change
    add_column :users, :uid, :string
    add_column :users, :provider, :string
    add_column :users, :display_name, :string
    add_column :users, :website, :string
    add_column :users, :nickname, :string
  end
end

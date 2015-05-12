class AddRefreshHashToUsers < ActiveRecord::Migration
  def change
    add_column :users, :refresh_hash, :string
  end
end

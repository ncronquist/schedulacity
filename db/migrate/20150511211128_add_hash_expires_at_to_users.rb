class AddHashExpiresAtToUsers < ActiveRecord::Migration
  def change
    add_column :users, :hash_expires_at, :datetime
  end
end

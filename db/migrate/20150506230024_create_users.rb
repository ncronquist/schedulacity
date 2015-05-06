class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password_digest
      t.string :phone_number
      t.string :provider
      t.string :provider_id
      t.string :provider_hash

      t.timestamps null: false
    end
  end
end

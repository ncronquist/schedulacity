class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.datetime :start
      t.datetime :end
      t.string :street_address
      t.string :city
      t.string :state
      t.string :zip
      t.references :classgroup, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end

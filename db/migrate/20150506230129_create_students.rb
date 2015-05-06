class CreateStudents < ActiveRecord::Migration
  def change
    create_table :students do |t|
      t.string :name
      t.text :note
      t.date :dob
      t.string :email
      t.string :phone_number
      t.string :street
      t.string :city
      t.string :state
      t.string :zip
      t.boolean :notifications

      t.timestamps null: false
    end
  end
end

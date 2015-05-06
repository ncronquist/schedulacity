class CreateAttendances < ActiveRecord::Migration
  def change
    create_table :attendances do |t|
      t.references :event, index: true, foreign_key: true
      t.references :student, index: true, foreign_key: true
      t.integer :attendance_type

      t.timestamps null: false
    end
  end
end

class CreateClassgroupsStudents < ActiveRecord::Migration
  def change
    create_table :classgroups_students do |t|
      t.references :classgroup, index: true, foreign_key: true
      t.references :student, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end

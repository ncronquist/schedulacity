class AddActiveToClassgroups < ActiveRecord::Migration
  def change
    add_column :classgroups, :active, :boolean
  end
end

class AddRangesToParameters < ActiveRecord::Migration
  def self.up
    remove_column :parameters, :threshold

    add_column :parameters, :level1, :float
    add_column :parameters, :level2, :float
    add_column :parameters, :level3, :float
    add_column :parameters, :level4, :float
  end

  def self.down
    add_column :parameters, :threshold, :float

    remove_column :parameters, :level1
    remove_column :parameters, :level2
    remove_column :parameters, :level3
    remove_column :parameters, :level4
  end
end

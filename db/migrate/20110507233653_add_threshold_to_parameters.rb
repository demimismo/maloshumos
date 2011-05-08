class AddThresholdToParameters < ActiveRecord::Migration
  def self.up
    add_column :parameters, :threshold, :float
  end

  def self.down
    add_column :parameters, :threshold
  end
end

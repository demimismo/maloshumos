class ChangeMeasurementsParameter < ActiveRecord::Migration
  def self.up
    rename_column :measurements, :parameter, :parameter_id
  end

  def self.down
    rename_column :measurements, :parameter_id, :parameter
  end
end

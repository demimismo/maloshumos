class CreateMeasurements < ActiveRecord::Migration
  def self.up
    create_table :measurements do |t|
      t.references :station
      t.integer :parameter
      t.datetime :measured_at
      t.float :reading
      t.integer :analytical_technique

      t.timestamps
    end
  end

  def self.down
    drop_table :measurements
  end
end

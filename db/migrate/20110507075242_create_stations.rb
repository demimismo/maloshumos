class CreateStations < ActiveRecord::Migration
  def self.up
    create_table :stations do |t|
      t.references :city
      t.string :name
      t.string :permalink
      t.integer :code
      t.integer :alt_code

      t.timestamps
    end
  end

  def self.down
    drop_table :stations
  end
end

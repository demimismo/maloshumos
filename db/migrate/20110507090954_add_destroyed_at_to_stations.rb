class AddDestroyedAtToStations < ActiveRecord::Migration
  def self.up
    add_column :stations, :destroyed_at, :datetime
  end

  def self.down
    remove_column :stations, :destroyed_at
  end
end

class AddPreviousStationIdToStations < ActiveRecord::Migration
  def self.up
    add_column :stations, :previous_station_id, :integer
  end

  def self.down
    remove_column :stations, :previous_station_id
  end
end

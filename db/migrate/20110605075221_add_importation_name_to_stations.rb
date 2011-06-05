class AddImportationNameToStations < ActiveRecord::Migration
  def self.up
    add_column :stations, :importation_name, :string
  end

  def self.down
    remove_column :stations, :importation_name
  end
end

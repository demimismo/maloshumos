class AddCoordinatesToStation < ActiveRecord::Migration
  def self.up
    add_column :stations, :longitude, :string
    add_column :stations, :latitude, :string
    add_column :stations, :longitude_decimal, :float
    add_column :stations, :latitude_decimal, :float
    add_column :stations, :height, :float
  end 

  def self.down
    remove_column :stations, :height
    remove_column :stations, :latitude
    remove_column :stations, :longitude
    remove_column :stations, :latitude_decimal
    remove_column :stations, :longitude_decimal
  end 
end

class Station < ActiveRecord::Base
  belongs_to :city
  has_slug :source_column => :name, :slug_column => :permalink, :prepend_id => false, :sync_slug => true

  before_save :convert_coordinates

  def convert_coordinates
    min_latitude = self.latitude.match(/([0-9,]{1,5})º\s?([0-9,]{1,5})'\s?([0-9,]{1,5})''.*/)
    min_longitude = self.longitude.match(/([0-9,]{1,5})º\s?([0-9,]{1,5})'\s?([0-9,]{1,5})''.*/)

    latitude, longitude = 0.00
    aux = 0

    min_latitude[1..3].each_index do |index|
      case index
        when 1
          aux = aux + Float(min_latitude[index])
        when 2 
          aux = aux + Float(min_latitude[index]) / 60.00
        when 3 
          aux = aux + Float(min_latitude[index]) / 3600.00
      end 
    end
    
    self.latitude_decimal = aux
    aux = 0

    min_longitude[1..3].each_index do |index|
      case index
        when 1
          aux = aux + Float(min_longitude[index])
        when 2 
          aux = aux + Float(min_longitude[index]) / 60.00
        when 3 
          aux = aux + Float(min_longitude[index]) / 3600.00
      end 
    end

    self.longitude_decimal = aux

  end
end

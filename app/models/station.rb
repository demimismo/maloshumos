class Station < ActiveRecord::Base
  belongs_to :city
  has_one :previous_station, :class_name => 'Station', :foreign_key => 'previous_station_id'
  has_many :measurements, :primary_key => 'code'

  named_scope :active, :conditions => {:destroyed_at => nil}

  has_slug :source_column => :name, :slug_column => :permalink, :prepend_id => false, :sync_slug => true

  before_save :convert_coordinates

  def convert_coordinates
    if !self.latitude.empty? 
      min_latitude = self.latitude.match(/([0-9,]{1,5})º\s?([0-9,]{1,5})'\s?([0-9,]{1,5})''.*/)
      latitude = 0.00

      min_latitude[1..3].each_index do |index|
        case index
          when 1
            latitude = latitude + Float(min_latitude[index])
          when 2 
            latitude = latitude + Float(min_latitude[index]) / 60.00
          when 3 
            latitude = latitude + Float(min_latitude[index]) / 3600.00
        end 
      end

      self.latitude_decimal = latitude
    end

    if !self.longitude.empty?
      min_longitude = self.longitude.match(/([0-9,]{1,5})º\s?([0-9,]{1,5})'\s?([0-9,]{1,5})''.*/)
      longitude = 0.00

      min_longitude[1..3].each_index do |index|
        case index
          when 1
            longitude = longitude + Float(min_longitude[index])
          when 2 
            longitude = longitude + Float(min_longitude[index]) / 60.00
          when 3 
            longitude = longitude + Float(min_longitude[index]) / 3600.00
        end 
      end

      self.longitude_decimal = longitude
    end
  end
end

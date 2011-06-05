class Station < ActiveRecord::Base
  belongs_to :city
  has_one :previous_station, :class_name => 'Station', :foreign_key => 'id', :primary_key => 'previous_station_id'
  has_many :measurements

  reverse_geocoded_by :latitude_decimal, :longitude_decimal

  scope :active, where(:destroyed_at => nil)
  scope :recently_destroyed, where("DATE_FORMAT(stations.destroyed_at, '%Y') IN (2008, 2009, 2010, 2011)")
  scope :recent, where(["created_at < ?", Date.parse('03/2011')])
  scope :moved, where("stations.previous_station_id > 0")

  has_slug :source_column => :name, :slug_column => :permalink, :prepend_id => false, :sync_slug => true

  #  The final index is the highest value of the sub-indices for each component
  def normalized_status(wadus = Time.now)
    self.measurements.taken_at(wadus).for_parameter(Parameter.mandatory_city).max_by { |m| m.normalized_reading }.normalized_reading rescue nil
  end

  def humanized_status(wadus = Time.now)
    case self.normalized_status(wadus)
      when 0..25    then 'bueno'
      when 26..50   then 'admisible'
      when 51..75   then 'malo'
      when 75..9999 then 'muymalo'
      else               'sindatos'
    end
  end

  def display_name
    "#{self.name}#{ " (cerrada)" unless self.destroyed_at.blank? }"
  end
end


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

  # El estado normalizado de una estación en un instante determinado
  # es la media de los valores de los parámetros clave
  def normalized_status(wadus = Time.now)
    data = self.measurements.in_key_params.taken_at(wadus).map(&:normalized_reading)
    data.sum/data.size
  end

  def humanized_status(wadus = Time.now)
    case self.normalized_status(wadus)
      when 1 then 'bueno'
      when 2 then 'admisible'
      when 3 then 'malo'
      when 4 then 'muymalo'
      else        'sindatos'
    end
  end

  def display_name
    "#{self.name}#{ " (cerrada)" unless self.destroyed_at.blank? }"
  end
end


class Measurement < ActiveRecord::Base
  belongs_to :station
  belongs_to :parameter

  validates_presence_of :parameter, :station_id
  validate :only_one_measurement_per_station_parameter_and_hour

  def only_one_measurement_per_station_parameter_and_hour
    measurement = Measurement.where :station_id   => self.station, 
                                    :parameter_id => self.parameter,
                                    :measured_at  => self.measured_at
    errors.add(:base, 'Only one measurement per station, parameter and hour is allowed') unless measurement.blank?
  end

  scope :for_parameter, lambda { |parameter|
    where(:parameter_id => parameter)
  }
  scope :latest_for_parameter, lambda { |parameter_code|
    { :conditions => ["measurements.parameter = ?", parameter_code], :limit => 1, :order => 'created_at desc' }
  }

  scope :taken_at, lambda { |wadus|
    where(["DATE_FORMAT(measurements.measured_at, '%Y%m%d%H') = ?", wadus.strftime('%Y%m%d%H')])
  }

  # Lectura normalizada (aplicando un valor guía del cual no hay mucho
  # consenso).
  #
  # A falta de algo mejor usaremos la tabla de Air Quality Now:
  # http://www.airqualitynow.eu/about_indices_definition.php
  #
  # Estos son los valores utilizados por la comunidad de Madrid:
  # http://www.mambiente.munimadrid.es/opencms/export/sites/default/calaire/Anexos/INDICE_URBANO_HORARIO.pdf
  def normalized_reading
    (1..4).each do |index|
      if self.reading < self.parameter.send("level#{index}")
        # We get the index by linear interpolation between the class borders
        from = self.parameter.send("level#{index}")
        from_low = self.parameter.send("level#{index}_low")
        to = self.parameter.send("grid#{index}")
        to_low = self.parameter.send("grid#{index}_low")
        return to_low + (self.reading - from_low) * (to - to_low) / (from - from_low)
      end
    end
    return -1
  end

  def humanized_reading
    case self.normalized_reading
      when 0..25    then 'bueno'
      when 26..50   then 'admisible'
      when 51..75   then 'malo'
      when 75..9999 then 'muymalo'
      else               'sindatos'
    end
  end
end


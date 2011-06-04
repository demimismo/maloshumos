class Measurement < ActiveRecord::Base
  belongs_to :station
  belongs_to :param, :class_name => 'Parameter', :primary_key => 'code', :foreign_key => 'parameter'

  validates_presence_of :parameter, :station_id
  validate :only_one_measurement_per_station_parameter_and_hour

  def only_one_measurement_per_station_parameter_and_hour
    measurement = Measurement.where :station     => self.station, 
                                    :parameter   => self.parameter,
                                    :measured_at => self.measured_at
    errors.add_to_base 'Only one measurement per station, parameter and hour is allowed' if measurement
  end

  scope :for_parameter, lambda { |parameter_code|
    { :conditions => ["measurements.parameter = ?", parameter_code] }
  }
  scope :latest_for_parameter, lambda { |parameter_code|
    { :conditions => ["measurements.parameter = ?", parameter_code], :limit => 1, :order => 'created_at desc' }
  }

  scope :in_key_params, lambda {
    { :conditions => ["measurements.parameter IN (?)", @@KEY_PARAMS.map(&:code)] }
  }
  
  scope :taken_at, lambda { |wadus|
    { :conditions => ["DATE_FORMAT(measurements.created_at, '%Y%m%d%H') = ?", wadus.strftime('%Y%m%d%H')] }
  }

  @@KEY_PARAMS = Parameter.key

  # Lectura normalizada (aplicando un valor guía del cual no hay mucho
  # consenso.
  #
  # A falta de algo mejor usaremos la tabla de Air Quality Now:
  # http://www.airqualitynow.eu/about_indices_definition.php
  #
  # Estos son los valores utilizados por la comunidad de Madrid:
  # http://www.mambiente.munimadrid.es/opencms/export/sites/default/calaire/Anexos/INDICE_URBANO_HORARIO.pdf
  def normalized_reading
    (4..1).each do |index|
      return index if self.reading < self.parameter.send("level#{index}")
    end
    return -1
  end

  def humanized_reading
    case self.normalized_reading
      when 1 then 'bueno'
      when 2 then 'admisible'
      when 3 then 'malo'
      when 4 then 'muymalo'
      else        'sindatos'
    end
  end
end


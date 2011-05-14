class Measurement < ActiveRecord::Base
  belongs_to :station, :primary_key => 'code'
  belongs_to :param, :class_name => 'Parameter', :primary_key => 'code', :foreign_key => 'parameter'

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

  @@KEY_PARAMS = Parameter.all :conditions => 'threshold > 0'

  # Lectura normalizada (aplicando un valor guía
  # del cual no hay mucho consenso, intentamos
  # guiarnos por este doc de la OMS:
  # http://whqlibdoc.who.int/hq/2006/WHO_SDE_PHE_OEH_06.02_spa.pdf
  #
  # Y por este de la comunidad de Madrid:
  # http://www.mambiente.munimadrid.es/opencms/export/sites/default/calaire/Anexos/INDICE_URBANO_HORARIO.pdf
  #
  # En todo caso parece claro que la Comunidad de
  # Madrid utiliza unos valores guía bastante
  # altos :)
  def normalized_reading
    (self.reading * 100) / self.param.threshold
  end
end


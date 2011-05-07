class Measurement < ActiveRecord::Base
  belongs_to :station

  named_scope :for_parameter, lambda { |parameter_code|
    { :conditions => ["measurements.parameter = ?", parameter_code] }
  }
  named_scope :latest_for_parameter, lambda { |parameter_code|
    { :conditions => ["measurements.parameter = ?", parameter_code], :limit => 1, :order => 'created_at desc' }
  }
end

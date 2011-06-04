class Parameter < ActiveRecord::Base
  scope :key, where('level1 > 0')
end

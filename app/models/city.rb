class City < ActiveRecord::Base
  has_slug :source_column => :name, :slug_column => :permalink, :prepend_id => false, :sync_slug => true
end

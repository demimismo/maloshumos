#!/usr/bin/ruby

require 'fastercsv'

# Taken from David Cabo's air-madrid project:
# https://github.com/dcabo/air-madrid/blob/master/parser/import_data.rb
class AirDataImporter
  
  def self.import

    # Process every data file stored in data dir
    Dir.glob(Rails.root.to_s, "data", "*.txt").each do |file|
      
      # You can read more about the data format here:
      # http://www.mambiente.munimadrid.es/opencms/export/sites/default/calaire/Anexos/INTPHORA-DIA.pdf
      while(cur_line = file.gets)
        station, parameter, method, period, year, month, day, packed_values = cur_line.unpack('a8a2a2a2a2a2a2a*')

        values = packed_values.unpack('a5x'*24).map{|v| v.to_f}
        values.each_with_index { |value, i|

          Measurement.create(
            :station => Station.find_by_code(station),
            :parameter => Parameter.find_by_code(parameter),
            :timestamp => Time.local(2000+year.to_i, month.to_i, day.to_i, i),
            :reading => value
          )
        }
        
      end
      file.close
    end

  end
  
  def self.import_stations
    FasterCSV.open("#{RAILS_ROOT}/data/stations.csv").each do |row|
      Station.create!(
       :city => City.find_by_name('Madrid'),
       :name => row[1],
       :code => row[0].split(' ')[0],
       :alt_code => row[0].split(' ')[1],
       :destroyed_at => (Date.strptime(row[2].match(/\d{1,}\/\d{1,}\/\d{4}/)[0], '%d/%m/%Y') rescue nil)
      )
    end
  end
end

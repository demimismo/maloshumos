namespace :madrid do

  desc "Cargar datos de parámetros"
  task :load_parameters => %w(environment) do
    FasterCSV.open("#{RAILS_ROOT}/data/parameters.csv").each do |row|
      Parameter.create!(
       :code => row[0],
       :formulation => row[1],
       :name => row[2]
      )
    end
  end

  desc "Cargar datos de estaciones"
  task :load_stations => %w(environment) do
    FasterCSV.open("#{RAILS_ROOT}/data/stations.csv").each do |row|
      Station.create!(
       :city => City.find_or_create_by_name('Madrid'),
       :name => row[1],
       :code => row[0].split(' ')[0],
       :alt_code => row[0].split(' ')[1],
       :destroyed_at => (Date.strptime(row[2], '%d/%m/%Y') rescue nil),
       :created_at => (Date.strptime(row[3], '%d/%m/%Y') rescue nil)
      )
    end
  end

  desc "Cargar datos de mediciones"
  task :load_measurements => %w(environment) do
    require File.join(Rails.root, 'vendor/plugins/seed-fu/lib/seed-fu/writer')
    # Process every data file stored in data dir
    Dir.glob(File.join(Rails.root.to_s, "data", "*.cor")).each do |filename|
      # You can read more about the data format here:
      # http://www.mambiente.munimadrid.es/opencms/export/sites/default/calaire/Anexos/INTPHORA-DIA.pdf
    seed_writer = SeedFu::Writer::SeedMany.new(
      :seed_file  => File.join( Rails.root, 'db', 'fixtures', 'measurements.rb' ),
      :seed_model => 'Measurement',
      :seed_by    => [ :id ]
    )

      FasterCSV.foreach(filename) do |row|
        station, parameter, method, period, year, month, day, packed_values = row[0].unpack('a8a2a2a2a2a2a2a*')

        values = packed_values.unpack('a5x'*24).map{|v| v.to_f}
        values.each_with_index do |value, i|

          seed_writer.add_seed({ 
            :station_id => station, #((Station.find_by_code(station) || Station.find_by_alt_code(station)).id rescue nil),
            :parameter => parameter, #Parameter.find_by_code(parameter),
            :created_at => Time.local(2000+year.to_i, month.to_i, day.to_i, i),
            :reading => value
          })

        end
      end
      seed_writer.finish
    end
  end
  
end


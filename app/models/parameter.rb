class Parameter < ActiveRecord::Base
  scope :mandatory_traffic, where(:formulation => ['NO2', 'PM10'])
  scope :auxiliary_traffic, where(:formulation => ['CO'])

  scope :mandatory_city, where(:formulation => ['NO2', 'PM10', 'O3'])
  scope :auxiliary_city, where(:formulation => ['CO', 'SO2'])

  (1..4).each do |index|
    define_method "level#{index}_low" do
      case index
        when 1 then 0
        else
          self.send("level#{index-1}")+1
      end
    end

    define_method "grid#{index}" do 25*index end

    define_method "grid#{index}_low" do
      case index
        when 1 then 0
        else
          self.send("grid#{index-1}")+1
      end
    end
  end

end


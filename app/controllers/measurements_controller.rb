class MeasurementsController < ApplicationController
  def index
    @city = City.slugged_find params[:city_id]
    @station = Station.slugged_find params[:station_id]
    @measurements = @station.measurements.for_parameter(12)
  end
end


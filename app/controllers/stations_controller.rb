class StationsController < ApplicationController

  def index
    if params[:postal_code]
      @station = Station.active.near("#{params[:postal_code]}, Madrid", 10).first

      redirect_to station_path(@station.permalink, :postal_code => params[:postal_code])
    elsif params[:station_id]
      @station = Station.find params[:station_id]

      redirect_to station_path(@station) and return
    elsif params[:date1] && params[:date2] && params[:station1] && params[:station2]
      @station1 = Station.find params[:station1]
      @station2 = Station.find params[:station2]
      @date1 = Date.parse(params[:date1])
      @date2 = Date.parse(params[:date2])
    else
      @comparable_stations = Station.all(:order => 'name asc')
    end
  end

  def show
    @city = City.slugged_find 'madrid'
    @station = Station.slugged_find params[:id]
    @measurement_time = @station.measurements.last.measured_at rescue Time.now
    @stations = Station.active
    respond_to do |format|
      format.html
      format.js
    end
  end
end


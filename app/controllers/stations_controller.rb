class StationsController < ApplicationController

  def index
    if params[:postal_code]
      pc_coordinates = Geokit::Geocoders::GoogleGeocoder.geocode "#{params[:postal_code]} Madrid"
      logger.info(pc_coordinates.lat)
      logger.info(pc_coordinates.lng)      
      @station = Station.find(:all, :origin => [pc_coordinates.lat, pc_coordinates.lng],
                              :within => 15, :limit => 1)
      redirect_to station_path(@station.first.permalink, :postal_code => params[:postal_code])
    end
  end

  def show
    @city = City.slugged_find 'madrid'
#    @city = City.slugged_find params[:city_id]
    @station = Station.slugged_find params[:id]
  end

  def versus
    @station1 = Station.slugged_find params[:id].split('-versus-')[0]
    @station2 = Station.slugged_find params[:id].split('-versus-')[1]
  end
  
end


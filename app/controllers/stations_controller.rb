class StationsController < ApplicationController
  def show
    @city = City.slugged_find params[:city_id]
    @station = Station.slugged_find params[:id]
  end

  def versus
    @station1 = Station.slugged_find params[:id].split('-versus-')[0]
    @station2 = Station.slugged_find params[:id].split('-versus-')[1]
  end
end


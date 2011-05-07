class CitiesController < ApplicationController
  def index
    @city = City.first
    respond_to do |format|
      format.html { render :action => :show }
    end
  end

  def show
    @city = City.slugged_find params[:id]
  end
end


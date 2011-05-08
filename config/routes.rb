ActionController::Routing::Routes.draw do |map|
  map.root :controller => 'site', :action => 'index'

  map.about '/about', :controller => 'site', :action => 'about'

  map.resources :cities, :as => 'ciudades' do |cities|
    cities.resources :stations, :as => 'estaciones' do |stations|
      stations.resources :measurements, :as => 'mediciones'
    end
  end



  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end

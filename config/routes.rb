Maloshumos::Application.routes.draw do
  ActiveAdmin.routes(self)

  devise_for :admin_users, ActiveAdmin::Devise.config

  root :to => 'site#index'

  match '/about', :to => 'site#about'
  match '/mediciones-trampa', :to => 'site#tricks'


  resources :cities, :path => 'ciudades' do
    resources :stations, :path => 'estaciones' do
      resources :measurements, :path => 'mediciones'
    end
  end

  resources :stations, :path => 'estaciones' do
    member do
      get 'compare'
    end
  end
end


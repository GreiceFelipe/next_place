Rails.application.routes.draw do
  resources :users, only: [:create, :update, :show]
  post '/auth/login', to: 'authentication#login'
  resources :places, only: [:create]
  get '/find_places', to: 'places#find_places'
  get '/list_places', to: 'places#list_places'
  get '/map_list_places', to: 'places#map_list_places'
  resources :rate_places, only: [:create]
  get '/rates_by_place', to: 'rate_places#rates_by_place'
end

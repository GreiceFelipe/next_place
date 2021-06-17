Rails.application.routes.draw do
  resources :users, only: [:create, :update, :show, :destory]
  post '/auth/login', to: 'authentication#login'
  resources :places, only: [:create]
  get '/find_places', to: 'places#find_places'
  get '/list_places', to: 'places#list_places'
  get '/map_list_places', to: 'places#map_list_places'
end

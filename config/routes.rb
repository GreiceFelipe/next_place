Rails.application.routes.draw do
  resources :users, only: [:create, :update, :show, :destory]
  post '/auth/login', to: 'authentication#login'
end

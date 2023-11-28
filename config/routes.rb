Rails.application.routes.draw do
  devise_for :users
  root 'home#index'

  resources :plants
  get '/database_info', to: 'database_info#show'
end

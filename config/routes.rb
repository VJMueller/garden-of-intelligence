Rails.application.routes.draw do
  devise_for :users
  root 'home#index'

  resources :users, only: %i[index show edit update destroy]
  resources :plants
  get '/database', to: 'database#show'
end

Rails.application.routes.draw do
  devise_for :users
  root 'home#index'

  resources :users, only: %i[index show edit update destroy]
  resources :plants
  resources :admin, only: %i[index]
  resources :database, only: %i[index]
end

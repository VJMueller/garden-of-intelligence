Rails.application.routes.draw do
  devise_for :users
  root 'home#index'

  get "/plants", to: "plants#index"
  get '/database_info', to: 'database_info#show'
end

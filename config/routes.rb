Rails.application.routes.draw do
    root "plants#index"

    resources :plants
    get '/database_info', to: 'database_info#show'
end

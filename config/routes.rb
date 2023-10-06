Rails.application.routes.draw do
    root "plants#index"

    get "/plants", to: "plants#index"
    get '/database_info', to: 'database_info#show'
end

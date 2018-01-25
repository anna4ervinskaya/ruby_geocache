Rails.application.routes.draw do
  get 'geoservice/index'
  resources :geolocations
  scope '/api' do
    get '/show/:id', to: "geo_api#show", as: "show", defaults: {format: :json}
    get '/list', to: "geo_api#index", as: "list", defaults: {format: :json}
    post '/create', to: "geo_api#create", as: "create", defaults: {format: :json}
    delete '/delete/:id',to: "geo_api#destroy", as: "delete", defaults: {format: :json}
    put '/update/:id',to: "geo_api#update", as: "update", defaults: {format: :json}
    get '/closest/:lat/:lng', to: "geo_api#closest", as: "closest", defaults: {format: :json}
    get '/in_radius/:lat/:lng', to: "geo_api#in_radius", as: "find_in_radius", defaults: {format: :json}
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

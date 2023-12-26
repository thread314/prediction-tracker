Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
  # Defines the root path route ("/")
  # root "posts#index"
  #
  root "predictors#index"
  get "/predictors", to: "predictors#index"
  get "/predictors/new", to: "predictors#new"
  post "/predictors/new", to: "predictors#create"
  post "/predictors/new", to: "predictors#create"
  get "/predictors/:id", to: "predictors#show"

end

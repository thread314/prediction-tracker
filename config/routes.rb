Rails.application.routes.draw do
  resources :outcomes
  resources :predictions
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
  get "/predictors/confirm", to: "predictors#confirm"
  post "/predictors", to: "predictors#create"
  get "/predictors/:id", to: "predictors#show", as: "predictor"


end

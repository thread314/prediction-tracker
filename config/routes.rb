Rails.application.routes.draw do
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  root "predictors#index"
  get "/predictors", to: "predictors#index"
  get "/predictors/new", to: "predictors#new"
  post "/predictors", to: "predictors#create"

  resource :predictors do
  # resource :predictors, only: [:index, :new, :create] do
    resources :predictions
  end

  get "/predictors/confirm", to: "predictors#confirm"
  get "/predictors/:id", to: "predictors#show", as: "predictor"

  resources :predictions, shallow: true do
    resources :comments
    resources :outcomes
    resources :reports
  end

  resources :outcomes, shallow: true do
    resources :comments
    resources :reports
  end

  resources :reports, shallow: true do
    resources :comments
  end

  resources :comments

end

Rails.application.routes.draw do
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  root "predictors#index"
  # get "/predictors", to: "predictors#index"
  # get "/predictors/new", to: "predictors#new"
  # post "/predictors", to: "predictors#create"

  resource :predictors do
    resources :predictions, only: [:index, :new, :create]
  end

  get "/predictors/confirm", to: "predictors#confirm"
  get "/predictors/:id", to: "predictors#show", as: "predictor"

  # resources :predictions, only: [:index, :show, :edit, :update, :destroy], shallow: true do
  resources :predictions, only: [:index, :show, :edit, :update, :destroy] do
    resources :outcomes, only: [:index, :new, :create]
    resources :reports, only: [:index, :new, :create]
    resources :comments, only: [:index, :new, :create]
  end

  resources :outcomes, only: [:index, :show, :edit, :update, :destroy] do
    resources :comments, only: [:index, :new, :create]
    resources :reports, only: [:index, :new, :create]
  end

  resources :reports, only: [:show, :edit, :update, :destroy] do
    resources :comments, only: [:index, :new, :create]
  end

  resources :comments

end

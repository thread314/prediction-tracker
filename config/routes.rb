Rails.application.routes.draw do
  devise_for :users
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  root "predictors#index"

  resources :predictors, only: [:index, :show, :new, :create] do
    resources :predictions, only: [:new, :create]
  end

  resources :predictions, only: [:index, :show, :edit, :update, :destroy] do
    resources :outcomes, only: [:new, :create]
    resources :reports, only: [:new, :create]
    resources :comments, only: [:new, :create]
  end

  resources :outcomes, only: [:show, :edit, :update, :destroy] do
    resources :comments, only: [:new, :create]
    resources :reports, only: [:new, :create]
  end

  resources :reports, only: [:index, :show, :edit, :update, :destroy] do
    resources :comments, only: [:new, :create]
  end

  resources :comments, only: [:destroy]

  post '/predictions/:id', to: 'predictions#vote', as: 'prediction_vote'
  post '/outcomes/:id', to: 'outcomes#vote', as: 'outcome_vote'

end


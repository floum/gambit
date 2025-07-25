Rails.application.routes.draw do
  resources :game_trainings
  resources :repertoires do
    collection do
      post :import, to: "repertoires#import"
    end
    member do
      get :train
      get :focus
      post :train, to: "repertoires#attempt"
      get :export
    end
  end
  resources :repertoire_moves, only: [ :destroy ] do
    member do
      post :attempt, path: ''
    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")
  root "repertoires#index"
end

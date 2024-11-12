Rails.application.routes.draw do
  resources :bands

  devise_scope :user_l do
    get "/user_ls", to: "devise/registration#new"
    get "/user_ls/password", to: "devise/passwords#new"
    get "/user_ls/sign_out" => "devise/sessions#destroy"
  end

  devise_for :user_ls

  get "home/about"
  resources :posts
  get "home/contact"
  resources :bands, only: [ :show, :edit, :update ]

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

   # Defines the root path route ("/")
   root "posts#index"
end

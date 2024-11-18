Rails.application.routes.draw do
  # Devise Routes
  devise_for :user_ls
  devise_scope :user_l do
    get "/user_ls", to: "devise/registrations#new"
    get "/user_ls/password", to: "devise/passwords#new"
    get "/user_ls/sign_out", to: "devise/sessions#destroy"
  end

  get 'posts/past', to: 'posts#past_events', as: :past_posts

  # Resource Routes
  resources :bands # Allowing full RESTful routes for bands
  resources :posts

  # Static Pages
  get "home/about"
  get "home/contact"
  get "home/contribute"

  # Health Check Route
  get "up", to: "rails/health#show", as: :rails_health_check

  # PWA Routes
  get "service-worker", to: "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest", to: "rails/pwa#manifest", as: :pwa_manifest

  # Root Route
  root "posts#index"
end

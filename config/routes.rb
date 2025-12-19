Rails.application.routes.draw do
  root "home#index"
  get "/home/guidelines", as: :guidelines
  resources :cats do
    member do
      post :feed
      post :reset_feeding
      post :spotted
      post :reset_spots
    end
  end
  get "up" => "rails/health#show", as: :rails_health_check
end

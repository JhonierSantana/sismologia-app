Rails.application.routes.draw do
  namespace :api do
    resources :earthquakes do
      resources :comments, only: [:create]
    end
  end

  get "/api/earthquakes" => "earthquakes#index"

  get "up" => "rails/health#show", as: :rails_health_check
end

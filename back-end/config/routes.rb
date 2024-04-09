Rails.application.routes.draw do
  namespace :api do
    resources :features, only: [] do
      resources :comments, only: [:create]
    end
    get "/features" => "earthquakes#index"
  end

  get "up" => "rails/health#show", as: :rails_health_check
end

Rails.application.routes.draw do
  get "/api/earthquakes" => "earthquakes#index"

  post "/api/earthquakes/:id/comments" => "comments#create"

  get "up" => "rails/health#show", as: :rails_health_check
end

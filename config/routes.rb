Rails.application.routes.draw do
  root "portfolio#index"

  namespace :admin do
    root "dashboard#index"
    resources :projects
    resources :skills
  end

  get "up" => "rails/health#show", as: :rails_health_check
end

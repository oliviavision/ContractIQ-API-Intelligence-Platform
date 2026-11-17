Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check
  namespace :api do
    namespace :v1 do
      post "auth/register", to: "auth#register"
      post "auth/login", to: "auth#login"
      delete "auth/logout", to: "auth#logout"
      resources :workspaces, only: %i[index create show] do
        resources :projects, only: %i[index create]
      end
      resources :projects, only: [] do
        resources :services, controller: "api_services", only: %i[index create]
      end
    end
  end
end

Rails.application.routes.draw do
  post "/login", to: "sessions#login"
  post "/signup", to: "sessions#signup"

  resources :todos
end

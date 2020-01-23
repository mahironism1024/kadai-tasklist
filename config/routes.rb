Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  root to: "tasks#index"
  resources :tasks
  
  get "signup", to: "users#new"
  get "users", to: "tasks#index"
  resources :users, only: [:show, :create]
  
  get "login", to: "sessions#new"
  post "login", to: "sessions#create"
  delete "logout", to: "sessions#destroy"
end

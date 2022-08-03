Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :lists, only: [:show, :new, :create]
  root to: "lists#home"
  # Defines the root path route ("/")
  # root "articles#index"
end

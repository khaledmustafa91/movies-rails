Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  namespace :movies do
    resources :imports, only: [:create]
  end

  namespace :reviews do
    resources :imports, only: [:create]
  end

  resources :movies
end

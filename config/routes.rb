Rails.application.routes.draw do
  get 'home/home'

  resources :movies
  resources :movie_instances

  root to: "home#home"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

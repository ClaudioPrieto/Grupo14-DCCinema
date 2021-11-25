Rails.application.routes.draw do
  get 'home/home'

  resources :movies
  resources :movie_instances do
    resources :reservations, only: [:index, :show, :new, :create]
    get '/movie_instance/:row/cols' => 'reservations#col_data'
  end

  root to: "home#home"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

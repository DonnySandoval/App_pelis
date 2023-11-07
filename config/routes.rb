Rails.application.routes.draw do
  get 'favorites/index'
  get 'favorites', to: 'favorites#index'

  get 'movie_details/show'
  devise_for :users
  
  

  get '/search_results', to: 'movies#search_results', as: 'search_results'

  get 'search_movies', to: 'movies#search', as: 'search_movies'

  resources :movies do
   
   
    post 'create', on: :collection
  end
  resources :movies, only: [:index, :create, :destroy ]
  get 'movie_details/:id', to: 'movie_details#show', as: 'movie_details'
  get 'movies/favorites', to: 'movies#index', as: 'favorite_movies'

  root 'movies#index'
end

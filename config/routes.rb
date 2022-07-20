Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'welcome#index'

  get '/registration', to: 'users#new'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  
  delete '/logout', to: 'sessions#destroy'


  get '/dashboard', to: 'users#show'

  get '/discover', to: 'discover#index'

  get '/discover/movies', to: 'movies#index'

  get '/discover/movies/:movie_id', to: 'movies#show'

  get '/discover/movies/:movie_id/parties/new', to: 'parties#new'
  post '/discover/movies/:movie_id/parties', to: 'parties#create'
  
  resources :users, only: %i[create]
  
end

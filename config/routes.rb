Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'welcome#index'

  get '/registration', to: 'users#new'
  get '/login', to: 'users#login_form'
  post '/login', to: 'users#login_user'

  resources :users, only: %i[show create] do
    resources :discover, only: %i[index]

    resources :movies, only: %i[index show] do
      resources :parties, only: %i[new create]
    end
  end
end

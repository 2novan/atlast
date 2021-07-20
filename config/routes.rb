Rails.application.routes.draw do
  get 'artists/index'
  get 'artists/show'
  get 'newsfeeds/index'
  unauthenticated do 
    root to: 'pages#home'
  end
  authenticated :user do 
    root to: 'newsfeeds#show', as: :newsfeed
  end
  resources :artists, only: [:index, :show] do 
    resources :my_artists, only: [:create]
  end
  resources :my_artists, only: [:index, :destroy]
  resources :releases, only: [:show]
  resources :concerts, only: [:show, :index]

  devise_for :users,
              controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

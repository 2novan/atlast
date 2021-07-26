Rails.application.routes.draw do
    require "sidekiq/web"
  authenticate :user, ->(user) { user.admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end
  get '/search' => 'pages#search', :as => 'search_page'
  get '/playlist' => 'playlists#index', :as => 'playlist'
  get '/playlist' => 'playlists#new', :as => 'new_playlist'

  unauthenticated do
    root to: 'pages#home'
  end
  authenticated :user do
    root to: 'newsfeeds#show', as: :newsfeed
  end
    get '/components' => 'pages#components'
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

Rails.application.routes.draw do
    require "sidekiq/web"
  authenticate :user, ->(user) { user.admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end
  get '/search' => 'pages#search', :as => 'search_page'
  resources :playlists, only: [:create, :new]

  unauthenticated do
    root to: 'pages#home'
  end

  authenticated :user do
    root to: 'newsfeeds#show', as: :newsfeed
  end
  get '/components' => 'pages#components'
  get '/welcome' => 'pages#welcome'

  get '/components' => 'pages#components'

  resource :newsfeed, only: [:show]

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

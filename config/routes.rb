Rails.application.routes.draw do
  get 'newsfeeds/index'
  get '/search' => 'pages#search', :as => 'search_page'
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

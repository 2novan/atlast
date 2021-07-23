Rails.application.routes.draw do
  get '/search' => 'pages#search', :as => 'search_page'
  get '/welcome' => 'pages#welcome'

  root to: 'pages#home'

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

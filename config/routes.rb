Rails.application.routes.draw do
  root 'pages#landing'
  get 'home' => 'pages#home'

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks", sessions: 'users/sessions' }

  resources :chat_rooms, only: [:new, :create, :show, :index]
  mount ActionCable.server => '/cable'
  get '/join_chat' => "chat_rooms#create"

  resources :comments, only: [:new, :create]

  resources :favorites, only: [:create,:destroy]
  get 'favorites' => 'pages#favorites', as: "my_favorites"
  post 'favorites/:id' => 'favorites#favorite'
  delete 'unfavorite/:id' => 'favorites#unfavorite', as: 'unfavorite'

  resources :pictures, only: [:new,:create,:edit,:show,:destroy]
  get 'upload' => 'pictures#new'

  resources :properties

  get 'feed', to: 'pages#feed'
  get 'message', to: 'pages#message'
  post '/feed' => "pages#feed", as: "feed_post"
  get '/pics' => "pages#pics"
  get 'profile' => 'pages#profile', as: "profile"
  get 'comments/create'
  get 'style' => 'pages#styleguide'

end

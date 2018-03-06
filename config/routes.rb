Rails.application.routes.draw do
  get 'comments/create'
  resources :favorites, only: [:create,:destroy]

  resources :pictures

  get 'feed', to: 'pages#feed'
  get 'message', to: 'pages#message'
  get 'home' => 'pages#home'
  get 'favorites' => 'pages#favorites'
  post '/feed' => "pages#feed", as: "feed_post"
  
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  root to: 'pages#landing'

  resources :chat_rooms, only: [:new, :create, :show, :index]
  mount ActionCable.server => '/cable'

  resources :comments, only: [:new, :create]
  post 'favorites/:id' => 'favorites#favorite'

  delete 'unfavorite/:id' => 'favorites#unfavorite', as: 'unfavorite'

end

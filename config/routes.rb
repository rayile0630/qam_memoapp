Rails.application.routes.draw do
  get 'comments/create'
  get 'comments/destroy'
  get 'favorites/create'
  get 'favorites/destroy'
  get 'relationships/create'
  get 'relationships/destroy'
  root to: 'toppages#index'
  
  get 'memoposts', to: 'posts#new'
  get 'posts/create'
  get 'posts/destroy'
  
  
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  get 'signup', to: 'users#new'
  resources :users, only: [:index, :show, :new, :create] do
    member do
      get :followings
      get :followers
      get :likes
      get :friendlists
    end
  end
  resources :posts, only: [:index, :show, :new, :create, :destroy]
  resources :relationships, only: [:create, :destroy]
  resources :favorites, only: [:create, :destroy]
  resources :comments, only: [:index, :show, :new, :create, :destroy]
end

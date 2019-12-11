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
  resources :users, only: [:index, :show, :new, :create, :edit, :update] do
    member do
      get :followings
      get :followers
      get :likes
      get :friendlists
    end
  end
  resources :posts, only: [:index, :show, :new, :create, :edit, :update, :destroy] do
      collection do
      get :search
      get :understandings
      get :subtles
      get :donotknows
      get :qam_square_understandings
      get :qam_square_subtles
      get :qam_square_donotknows
      get :my_index
      get :news
      get :rankings
    end
  end
  resources :relationships, only: [:create, :destroy]
  resources :favorites, only: [:create, :destroy]
  resources :comments, only: [:index, :show, :new, :create, :destroy]
end

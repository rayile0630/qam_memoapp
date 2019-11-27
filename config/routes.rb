Rails.application.routes.draw do
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
    end
  end
  resources :posts, only: [:show, :new, :create, :destroy]
  resources :relationships, only: [:create, :destroy]
end

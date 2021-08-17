Rails.application.routes.draw do
  root to: 'toppages#top'
  get 'about', to: 'toppages#about'

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  post 'guest_login', to: 'sessions#guest_login'
  delete 'logout', to: 'sessions#destroy'

  get 'terms', to: 'terms#terms'
  get 'policy', to: 'policies#policy'

  get 'signup', to: 'users#new'
  resources :users, only: [:index, :show, :create, :edit, :update, :destroy] do
    member do
      get :followings
      get :followers
      get :likes
    end
  end

  resources :posts, only: [:index, :show, :new, :create, :destroy]
  resources :posts do
    resources :comments, only: [:create, :destroy]
  end

  resources :relationships, only: [:create, :destroy]
  resources :favorites, only: [:create, :destroy]
end

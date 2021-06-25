Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
     #Prefix Verb   URI Pattern               Controller#Action
     #root GET    /                         toppages#top
    #about GET    /about(.:format)          toppages#about
    #login GET    /login(.:format)          sessions#new
    #     POST   /login(.:format)          sessions#create
  #logout DELETE /logout(.:format)         sessions#destroy
   #signup GET    /signup(.:format)         users#new
#followings_user GET    /users/:id/followings(.:format) users#followings
#followers_user GET    /users/:id/followers(.:format)  users#followers
    #users GET    /users(.:format)          users#index
          #POST   /users(.:format)          users#create
#edit_user GET    /users/:id/edit(.:format) users#edit
     #user GET    /users/:id(.:format)      users#show
          #PATCH  /users/:id(.:format)      users#update
          #PUT    /users/:id(.:format)      users#update
          #DELETE /users/:id(.:format)      users#destroy
#likes_user GET    /users/:id/likes(.:format)      users#likes
     #posts GET    /posts(.:format)          posts#index
  #       POST   /posts(.:format)          posts#create
#new_post GET    /posts/new(.:format)      posts#new
  #  post GET    /posts/:id(.:format)      posts#show
  #       DELETE /posts/:id(.:format)      posts#destroy
#relationships POST   /relationships(.:format)        relationships#create
#relationship DELETE /relationships/:id(.:format)    relationships#destroy
  #favorites POST   /favorites(.:format)            favorites#create
  #favorite DELETE /favorites/:id(.:format)        favorites#destroy
          
  root to: 'toppages#top'
  get 'about', to: 'toppages#about'
  
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  get 'signup', to: 'users#new'
  resources :users, only: [:index, :show, :create, :edit, :update, :destroy] do
    member do
      get :followings
      get :followers
      get :likes
    end
  end
  
  resources :posts, only: [:index, :show, :new, :create, :destroy]
  resources :relationships, only: [:create, :destroy]
  resources :favorites, only: [:create, :destroy]
  
end

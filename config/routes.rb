Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
     #Prefix Verb   URI Pattern               Controller#Action
     #root GET    /                         toppages#top
    #about GET    /about(.:format)          toppages#about
    #login GET    /login(.:format)          sessions#new
    #     POST   /login(.:format)          sessions#create
  #logout DELETE /logout(.:format)         sessions#destroy
   #signup GET    /signup(.:format)         users#new
    #users GET    /users(.:format)          users#index
          #POST   /users(.:format)          users#create
#edit_user GET    /users/:id/edit(.:format) users#edit
     #user GET    /users/:id(.:format)      users#show
          #PATCH  /users/:id(.:format)      users#update
          #PUT    /users/:id(.:format)      users#update
          #DELETE /users/:id(.:format)      users#destroy
          
  root to: 'toppages#top'
  get 'about', to: 'toppages#about'
  
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  get 'signup', to: 'users#new'
  resources :users, only: [:index, :show, :create, :edit, :update, :destroy]
  
end

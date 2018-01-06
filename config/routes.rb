Rails.application.routes.draw do
  get 'password_resets/new'

  get 'password_resets/edit'

  get 'sessions/new'

  get 'static_pages/home' => 'static_pages#home'
  get 'static_pages/help'=> 'static_pages#help'
  get 'static_pages/about'=> 'static_pages#about'
  get 'static_pages/contact'=> 'static_pages#contact'
  resources :users do 
    member do 
      get :following, :followers
    end
  end
  root 'static_pages#home'

  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  delete '/logout' => 'sessions#destroy'
  resources :account_activations, only: [:edit]
  resources :password_resets, only: [:new, :edit, :create, :update]
  resources :microposts, only: [:create, :destroy]
  resources :relationships,       only: [:create, :destroy]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

Rails.application.routes.draw do
  get 'sessions/new'

  get 'static_pages/home' => 'static_pages#home'
  get 'static_pages/help'=> 'static_pages#help'
  get 'static_pages/about'=> 'static_pages#about'
  get 'static_pages/contact'=> 'static_pages#contact'
  resources :users
  root 'static_pages#home'

  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  delete '/logout' => 'sessions#destroy'
  resources :account_activations, only: [:edit]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

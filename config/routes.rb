Rails.application.routes.draw do
  get 'home/index'

  get '/signup', to: 'users#new'
  
  resources :articles do
    resources :comments
  end

  root 'home#index'
end

Rails.application.routes.draw do
  
#get '/home/:id', to: 'home#index', as: 'home'

resources :sessions, only: [:new, :create, :destroy]

  resources :users do
    member do
      get :confirm_email
      get :home
    end
  end
  get 'signup', to: 'users#new', as: 'signup'
  get 'login', to:'sessions#new',as: 'login'
  get 'logout', to:'sessions#destroy', as:'logout'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "users#home"
end
1
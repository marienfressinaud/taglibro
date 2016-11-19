Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'welcome#index'

  resources :users, only: [:new, :create] do
    member do
      get :activate
    end
  end
  resources :user_sessions, only: [:new, :create, :destroy]
  resources :password_resets, only: [:new, :create, :edit, :update]

  get 'register' => 'users#new', as: :register
  get 'login' => 'user_sessions#new', as: :login
  post 'logout' => 'user_sessions#destroy', as: :logout

  resources :thoughts, only: [:create]

  get 'diary' => 'users#diary'
  get 'explore' => 'thoughts#explore'

end

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'users#new'

  resources :users, only: [:new, :create] do
    member do
      get :activate
    end
  end
  resources :user_sessions, only: [:new, :create]

  get 'login' => 'user_sessions#new', as: :login
end

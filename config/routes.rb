Rails.application.routes.draw do
  namespace :user, path: '' do
    root 'top#index'
    get 'login' => 'sessions#new', as: :login
    resource :session,          only: [ :create, :destroy ]
    
    get 'home' => 'users#home', as: :home
    resource :user, expect: [ :new, :create ]
    resources :activities
    resources :achievements
    resources :relationships,   only: [ :create, :destroy ]

    resources :users do
      member do
        get :following, :followers
        resources :activities,    only: [ :index, :show ]
        resources :achievements,  only: [ :index, :show ]
      end
    end
  end
end

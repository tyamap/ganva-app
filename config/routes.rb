Rails.application.routes.draw do
  namespace :user, path: '' do
    root 'top#index'
    get 'login' => 'sessions#new', as: :login
    resource :session,          only: [ :create, :destroy ]
    
    get 'home' => 'top#home', as: :home
    resource :account, only: [ :show, :edit, :update ]
    resource :profile, only: [ :show, :edit, :update ]
    resource :password, only: [ :show, :edit, :update ]
    resources :activities
    resources :achievements
    resources :gyms, only: [ :index, :show ]
    resources :relationships,   only: [ :create, :destroy ]

    resources :users do
      resources :activities,    only: [ :index, :show ]
      resources :achievements,  only: [ :index, :show ]
      member do
        get :following, :followers
      end
    end
  end
end

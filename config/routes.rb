Rails.application.routes.draw do
  namespace :user, path: '' do
    root 'top#index'
    get 'login' => 'sessions#new', as: :login
    resource :session, only: [ :create, :destroy ]

    resources :accounts, only: [ :create ,:index ]
    get '/register' => 'accounts#new', as: :register
    resource :account, except: [ :new, :create, :delete ]
    get '/:uid' => 'accounts#show'

    get '/home' => 'accounts#home', as: :home
  end
end

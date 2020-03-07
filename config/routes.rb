Rails.application.routes.draw do
  namespace :user, path: '' do
    root 'top#index'
    get 'login' => 'sessions#new', as: :login
    resource :session, only: [ :create, :destroy ]

    get '/:uid' => 'accounts#show'
    resources :accounts, except: [ :index, :show ]

    get '/home' => 'accounts#home', as: :home
  end
end

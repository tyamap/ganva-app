Rails.application.routes.draw do
  namespace :user, path: '' do
    root 'top#index'
    resources :users, only: [ :new, :create ,:index ]
    get 'login' => 'sessions#new', as: :login
    resource :session, only: [ :create, :destroy ]
    
    get '/home' => 'accounts#show', as: :home
    resource :account, except: [ :new, :create, :delete ]
    resources :activities
    resources :users, param: :uid, path: '/', only: [ :show ]
    scope '/:uid' do
      resources :activities, only: [ :index, :show ], as: :user_activities
    end
  end
end

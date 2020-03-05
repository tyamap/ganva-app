Rails.application.routes.draw do
  namespace :user, path: '' do
    root 'top#index'
    get 'login' => 'sessions#new', as: :login
    get '/home' => 'accounts#home', as: :home
    get '/:uid' => 'accounts#show'
    resource :session, only: [ :create, :destroy ]
  end
end

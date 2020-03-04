Rails.application.routes.draw do
  namespace :user do
    root 'top#index'
    get "login" => "sessions#new", as: :login
    resource :session, only: [ :create, :destroy ]
  end
end

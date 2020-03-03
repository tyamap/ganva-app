Rails.application.routes.draw do
  devise_for :users
  namespace :user do
    root 'top#index'
  end
end

Rails.application.routes.draw do
  namespace :user do
    root 'top#index'
  end
end

Rails.application.routes.draw do
  root 'page#index'

  namespace :admin do
    root 'dashboard#index'
    resources :sessions, only: [:new, :create, :destroy]
  end
end

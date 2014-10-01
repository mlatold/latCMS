Rails.application.routes.draw do

  namespace :admin do
    root 'dashboard#index'
    resources :sessions, only: [:new, :create, :destroy]
    resources :users, except: :show
    resources :pages
  end

  root "application#render_page"
  match '*unmatched_route', :to => 'application#render_page', via: :get
end

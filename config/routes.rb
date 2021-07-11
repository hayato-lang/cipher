Rails.application.routes.draw do
  devise_for :admin_users
  root to: 'events#index'
  resources :events, only: [:index, :new, :create, :show]
end

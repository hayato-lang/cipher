Rails.application.routes.draw do
  devise_for :admin_users
  root to: 'events#index'
  resources :events, only: %i[index new create show]
end

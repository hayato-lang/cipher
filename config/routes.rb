Rails.application.routes.draw do
  devise_for :admin_users, controller: {registrations: 'admin_users/registrations'}
  root to: 'events#index'
  resources :events
end


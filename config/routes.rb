Rails.application.routes.draw do
  devise_for :admin_users, controllers: {
    registrations: 'admin_users/registrations'
  }
  devise_scope :admin_user do
    get 'admin_profiles', to: 'admin_users/registrations#new_admin_profiles'
    post 'admin_profiles', to: 'admin_users/registrations#create_admin_profiles'
  end
  root to: 'events#index'
  resources :events
end


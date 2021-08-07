Rails.application.routes.draw do
  devise_for :admin_users, controllers: {
    registrations: 'admin_users/registrations'
  }
  devise_scope :admin_user do
    get 'admin_profiles', to: 'admin_users/registrations#new_admin_profile'
    post 'admin_profiles', to: 'admin_users/registrations#create_admin_profile'
  end
  root to: 'events#index'
  resources :events do
    resources :comments, only: :create
    collection do
      get 'search'
    end
  end
  resources :admin_users, only: :show
end

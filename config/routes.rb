Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    passwords: 'users/passwords',
    registrations: 'users/registrations'
  }
  devise_for :admin_users, controllers: {
    sessions: 'admin_users/sessions',
    passwords: 'admin_users/passwords',
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

  post 'like/:id' => 'likes#create', as: 'create_like'
  delete 'like/:id' => 'likes#destroy', as: 'destroy_like'

  resources :admin_users, only: :show
end

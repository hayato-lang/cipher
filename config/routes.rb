Rails.application.routes.draw do
  devise_for :admin_users
  root to: "events#index"
end

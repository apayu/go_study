Rails.application.routes.draw do
  devise_for :admin_users

  root to: "currencies#index"

  resources :currencies
end

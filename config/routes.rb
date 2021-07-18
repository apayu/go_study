Rails.application.routes.draw do
  resources :courses
  devise_for :admin_users

  root to: "courses#index"

  resources :currencies

  resources :categories

  mount CourseStore::Base => '/'
end

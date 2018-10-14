Rails.application.routes.draw do
  root 'uploaded_files#index'
  devise_for :users

  namespace :staff_only do
    resources :users, except: [:new, :create]
  end

  resources :uploaded_files, except: [:edit]
  mount Shrine.presign_endpoint(:cache) => "/api/presign"
end

Rails.application.routes.draw do
  root 'uploaded_files#index'
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :uploaded_files, except: [:edit]
end

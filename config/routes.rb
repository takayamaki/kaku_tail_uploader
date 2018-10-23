Rails.application.routes.draw do
  root 'uploaded_files#index'
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  namespace :staff_only do
    resources :users, only: [:index, :show] do 
      resource :role, only: [] do
        member do
          post :upgrade
          post :downgrade
        end
      end
    end
  end

  resources :uploaded_files, except: [:edit]
  mount Shrine.presign_endpoint(:cache) => "/api/presign"

  match '/401', to: 'errors#unauthorized', via: :all
  match '/403', to: 'errors#forbidden', via: :all
  match '/404', to: 'errors#not_found', via: :all
end

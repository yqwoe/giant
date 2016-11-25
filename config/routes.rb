Rails.application.routes.draw do

  devise_for :users

  root to: 'admin/home#index'

  namespace :api do
    namespace :v1 do
      resources :authenticate
      resource :users
      resources :cars, only: [:index, :show]
    end
  end
end

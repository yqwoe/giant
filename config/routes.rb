Rails.application.routes.draw do

  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }

  root to: 'admin/home#index'

  namespace :api do
    namespace :v1 do
      resources :authenticate
      resource :users do
        member do
          post 'verify'
        end
      end
      resources :car_brands, only: [:index, :show]
    end
  end
end

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
          get 'send_pin'
        end
      end
      resources :cars, only: [:create]
      resources :car_brands, only: [:index, :show]
      resources :cards, only: [:create]
      resources :deals, only: [:index, :show]
      resources :shops, only: [:index, :show]
    end
  end
end

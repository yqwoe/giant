Rails.application.routes.draw do

  root to: 'admin/home#index'

  resources :phones, only: [:new, :create]
  post 'phones/verify' => "phones#verify"

  namespace :users do
    resources :invitations
  end

  devise_for :users, controllers: {
    sessions: 'users/sessions',
  }

  namespace :api do
    namespace :v1 do
      resources :authenticate
      resources :payments
      resources :orders
      resources :comments
      resource :users do
        member do
          post 'verify'
          get 'send_pin'
        end
      end
      resources :cars, only: [:index, :create]
      match :wash, to: 'cars#wash', via: :post
      resources :car_brands, only: [:index, :show]
      resources :cards, only: [:create]
      resources :deals, only: [:index, :show, :create]
      resources :shops, only: [:index, :show] do
        collection do
          get :search
        end
      end
    end
  end
end

require 'resque/server'

Rails.application.routes.draw do
  root to: 'home#index'

  resource :ads
  resources :phones, only: [:new, :create]
  post 'phones/verify' => "phones#verify"

  namespace :users do
    resources :invitations
  end

  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }

  authenticate :user, -> (user) { user.admin? } do
    mount PgHero::Engine, at: "pghero"
    mount Resque::Server, at: '/jobs'
  end

  namespace :admin do
    resources :car_models
    resources :messages
    resources :car_brands do
      resources :car_models
    end

    resources :shops do
      get :autocomplete_car_licensed_id, on: :collection
      collection do
        patch 'inactive'
        patch 'active'
        patch 'pending'
      end
      resources :deals
    end

    resources :deals
    resources :cards
    get '/', to: 'home#index'
    resources :users do
      collection do
        post 'search'
      end
    end
    resources :cars do
      resources :deals
    end
  end


  namespace :api, defaults: {format: :json} do
    namespace :v2 do
      match :wash, to: 'cars#wash', via: :post
    end
  end

  namespace :api, defaults: {format: :json} do
    namespace :v1 do
      get '/growing_enrolled', to: 'growings#enrolled'
      resources :plates
      resources :authenticate
      resources :payments
      resources :suite_payments
      resources :orders do
        collection do
          post :notify
        end
      end
      resources :comments
      resources :messages
      resources :violations
      resources :ads
      resource :users do
        member do
          post 'verify'
          get 'send_pin'
        end
      end
      resources :cars, only: [:index, :create]
      match :wash, to: 'cars#wash', via: :post
      match :fuzz, to: 'cars#fuzz', via: :post
      resources :car_brands, only: [:index, :show]
      resources :cards, only: [:create]
      resources :deals, only: [:index, :show, :create] do
        collection do
          get :qrcode
        end
      end
      resources :shops, only: [:index, :show] do
        collection do
          get :search
          get :counties
          get :list
        end
        member do
          get :current
        end
      end
      resource :version, only: [:show]
      get :use_new_qrcode, to: 'versions#use_new_qrcode'
      resources :shop_detail, only: [:show]
      resources :coupons,     only: [:index]
      post 'growings', to: 'growings#create'
      resources :suites
      resources :shop_cities, only: [:index, :show]
    end
  end

  mount StatusPage::Engine, at: '/'
  get '/api' => redirect('/swagger/dist/index.html?url=/apidocs/api-docs.yml')
end

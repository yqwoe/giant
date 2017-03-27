Rails.application.routes.draw do

  root to: 'admin/home#index'

  resource :ads
  resources :phones, only: [:new, :create]
  post 'phones/verify' => "phones#verify"

  namespace :users do
    resources :invitations
  end

  devise_for :users, controllers: {
    sessions: 'users/sessions',
  }

  authenticate :user, -> (user) { user.admin? } do
    mount PgHero::Engine, at: "pghero"
  end

  namespace :admin do
    resources :shops
    resources :deals
    resources :cards
    get '/', to: 'home#index'
    resources :users do
      collection do
        post 'search'
      end
    end
    resources :cars
  end

  namespace :api do
    namespace :v1 do
      resources :authenticate
      resources :payments
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
      resources :car_brands, only: [:index, :show]
      resources :cards, only: [:create]
      resources :deals, only: [:index, :show, :create]
      resources :shops, only: [:index, :show] do
        collection do
          get :search
          get :counties
        end
      end
      resource :version, only: [:show]
    end
  end

  mount StatusPage::Engine, at: '/'
end

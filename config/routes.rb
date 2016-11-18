Rails.application.routes.draw do
  use_doorkeeper
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  #

  root to: 'admin/home#index'

  namespace :api do
    namespace :v1 do
      resources :users
    end
  end
end

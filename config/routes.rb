Rails.application.routes.draw do
  root "products#index"

  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'

  namespace :api do
    namespace :v1 do
      resources :orders do
         get 'cart', on: :collection
         get 'placed', on: :collection
         put 'change_state', on: :member
         put :update
      end
      resources :products
      resources :order_items do
        put :update
      end
      resources :addresses do
        put :update
      end
      resources :credit_cards do
        put :update
      end
    end
  end

  resources :products

  resources :checkout do
    get 'thank_you'
  end

  namespace :admin do
    resources :users, :coupons, :credit_cards, :payments, :products
    resources :orders do
      put :change_state
    end
  end

  devise_for :users, controllers: { registrations: 'registrations' }
end

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
      end
      resources :products
      resources :order_items
      resources :addresses
      resources :credit_cards
      resources :coupons
    end
  end

  get 'thank_you', to: 'checkout#thank_you'

  resources :products
  resources :checkout

  namespace :admin do
    resources :users, :coupons, :credit_cards, :payments, :products
    resources :orders do
      put :change_state
    end
  end

  devise_for :users, controllers: { registrations: 'registrations' }
end

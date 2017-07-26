Rails.application.routes.draw do
  root "products#index"
  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'
  namespace :api do
    namespace :v1 do
      resources :orders do
         get 'cart', on: :collection, to: 'orders#cart'
         get 'placed', on: :collection, to: 'orders#get_placed'
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
  resources :checkout
  get 'thank_you', to: 'checkout#summary'
  namespace :admin do
    resources :users, :coupons, :credit_cards, :payments, :products
    resources :orders do
      put :change_state
    end
  end

  devise_for :users, controllers: { registrations: 'registrations' }
end

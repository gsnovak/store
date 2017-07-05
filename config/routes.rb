Rails.application.routes.draw do
  root 'products#index'

  namespace :api do
    namespace :v1 do
      resources :orders do
         get 'cart', on: :collection, to: 'orders#cart'
      end
      resources :products
      resources :order_items do
        put :update
      end
      resources :address do
        put :update
      end
      resources :credit_cards do
        put :update
      end
    end
  end
  resources :products
  resources :checkout
  namespace :admin do
    resources :users, :coupons, :credit_cards, :payments, :products
    resources :orders do
      put :change_state
    end
  end

  devise_for :users, controllers: { registrations: 'registrations' }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end


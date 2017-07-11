Rails.application.routes.draw do
  root "products#index"
  namespace :api do
    namespace :v1 do
      resources :order do
         get 'cart', on: :collection, to: 'order#cart'
         put :update
      end
      resources :product
      resources :order_item do
        put :update
      end
      resources :address do
        put :update
      end
      resources :credit_card do
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
end


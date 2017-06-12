Rails.application.routes.draw do

  namespace :admin do
    resources :users, :orders, :coupons, :credit_cards, :payments, :products
  end

  devise_for :users, controllers: { registrations: 'registrations' }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

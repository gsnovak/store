FactoryGirl.define do

  sequence :email do |n|
    "person#{n}@example.com"
  end

  sequence :user_name do |n|
    "username#{n}"
  end

  factory :product do
    name "My Amazing Article"
    available true
    on_hand_count 10
    price 10.00
  end

  factory :user do
    user_name { generate :user_name }
    email { generate :email }
    password 'password123'
  end

  factory :state do
    abbreviation 'WI'
    name 'Wisconsin'
  end

  factory :address do
    street_addr '12b baker street'
    association :state, factory: :state
    association :user, factory: :user
    city 'Milwaukee'
    zip_code 53209
  end

  factory :coupon do
    amount 121.12
    name 'Best Coupon Ever'
  end

  factory :credit_card do
    first_name 'John'
    last_name 'Doe'
    token "1233432"
    year 2017
    month 10
    association :user, factory: :user
  end

  factory :payment do
    amount '111.11'
    association :credit_card, factory: :credit_card
  end

  factory :order do
    state :cart
    association :user, factory: :user
  end
end

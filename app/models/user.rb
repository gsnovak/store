class User < ApplicationRecord
  SYSTEM_ID = 1
  validates :encrypted_password, :user_name, presence: true
  validates :email, :user_name, uniqueness: true
  has_many :orders
  has_one :credit_card
  has_one :address
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end

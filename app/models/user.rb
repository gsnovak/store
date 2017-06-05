class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  validates :username, presence: true

  has_many :orders
  has_one :credit_card
  has_one :address
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end

class Coupon < ApplicationRecord
  belongs_to :source, polymorphic: true 
end

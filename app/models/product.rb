class Product < ApplicationRecord
  belongs_to :source, polymorphic: true 
end

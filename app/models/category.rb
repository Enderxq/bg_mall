class Category < ApplicationRecord
  has_many :kinds
  has_many :products
end

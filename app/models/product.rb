class Product < ApplicationRecord
  belongs_to :kind
  belongs_to :category, :optional => true
end

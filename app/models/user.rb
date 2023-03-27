class User < ApplicationRecord

  has_secure_password
  validates :password, :length => { :minimum => 6}
  validates_confirmation_of :password

  has_many :shopping_cars
  has_many :orders
  has_many :addresses

end

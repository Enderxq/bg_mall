class User < ApplicationRecord

  has_secure_password
  validates :password, :length => { :minimum => 6}
  validates_confirmation_of :password

end

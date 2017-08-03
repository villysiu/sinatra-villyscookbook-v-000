class User < ActiveRecord::Base
  validates_presence_of :name, :email, :password
  validates_uniqueness_of :name, :email
  has_secure_password validations: true

  has_many :recipes
end

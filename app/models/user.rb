class User < ActiveRecord::Base
  validates_presence_of :name, :email, :password
  validates_uniqueness_of :name, :email
  has_secure_password validations: true

  has_many :recipes

  def slug
    self.name.downcase.gsub(' ','-')
  end

  def self.find_by_slug(slug)
    self.all.detect{|user| user.name.downcase == slug.gsub('-',' ')}
  end
end
